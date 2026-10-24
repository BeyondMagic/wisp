#!/usr/bin/env python3
"""
update_metrics.py

Extracts Git commit activity and issue workload metrics to generate
Mermaid chart snippets under documentation/snippets/management/.
"""

import json
import os
import re
import subprocess
import sys
from collections import defaultdict
from datetime import datetime, timedelta
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
SNIPPETS_DIR = REPO_ROOT / "documentation" / "snippets" / "management"

TRACKED_AUTHORS = ["BeyondMagic", "github-actions[bot]"]


def normalize_author(name: str, email: str) -> str:
    """Normalize git author signature to recognized GitHub handles."""
    combined = f"{name} {email}".lower()
    if "github-actions" in combined or "actions@github.com" in combined:
        return "github-actions[bot]"
    if "beyondmagic" in combined or "koetemagie" in combined or "joão" in combined or "joao" in combined:
        return "BeyondMagic"
    return name.strip() or "Unknown"


def get_git_log_data():
    """Extract commit timestamps, normalized authors, additions, and deletions."""
    cmd = [
        "git",
        "log",
        "--numstat",
        "--date=iso-strict",
        "--format=COMMIT|%ad|%an|%ae",
    ]
    result = subprocess.run(cmd, cwd=REPO_ROOT, capture_output=True, text=True, check=True)
    lines = result.stdout.splitlines()

    commits_by_week = defaultdict(lambda: defaultdict(int))
    additions_by_week = defaultdict(lambda: defaultdict(int))
    deletions_by_week = defaultdict(lambda: defaultdict(int))
    all_weeks = set()

    current_week = None
    current_author = None

    for line in lines:
        line = line.strip()
        if not line:
            continue
        if line.startswith("COMMIT|"):
            parts = line.split("|")
            date_str = parts[1]
            author_name = parts[2]
            author_email = parts[3] if len(parts) > 3 else ""

            dt = datetime.fromisoformat(date_str)
            iso_year, iso_week, _ = dt.isocalendar()
            week_key = f"{iso_year}-W{iso_week:02d}"

            current_week = week_key
            current_author = normalize_author(author_name, author_email)
            all_weeks.add(week_key)

            commits_by_week[week_key][current_author] += 1
        else:
            # numstat line: <added> <deleted> <filename>
            parts = line.split("\t")
            if len(parts) >= 3 and current_week and current_author:
                added = int(parts[0]) if parts[0].isdigit() else 0
                deleted = int(parts[1]) if parts[1].isdigit() else 0
                additions_by_week[current_week][current_author] += added
                deletions_by_week[current_week][current_author] += deleted

    if not all_weeks:
        now_year, now_week, _ = datetime.now().isocalendar()
        all_weeks.add(f"{now_year}-W{now_week:02d}")

    # Generate sequential weekly buckets from earliest to latest
    sorted_weeks = sorted(all_weeks)
    earliest_yr, earliest_wk = [int(x) for x in sorted_weeks[0].split("-W")]
    latest_yr, latest_wk = [int(x) for x in sorted_weeks[-1].split("-W")]

    from datetime import date
    earliest_date = date.fromisocalendar(earliest_yr, earliest_wk, 1)
    latest_date = date.fromisocalendar(latest_yr, latest_wk, 1)

    full_weeks = []
    curr = earliest_date
    while curr <= latest_date or len(full_weeks) < 3:
        yr, wk, _ = curr.isocalendar()
        wk_str = f"{yr}-W{wk:02d}"
        if wk_str not in full_weeks:
            full_weeks.append(wk_str)
        curr += timedelta(days=7)

    return full_weeks, commits_by_week, additions_by_week, deletions_by_week


def get_issue_counts():
    """Retrieve issue counts per contributor via GitHub CLI or API."""
    counts = {author: 0 for author in TRACKED_AUTHORS}

    # Attempt fetching via gh CLI if present
    try:
        cmd = ["gh", "issue", "list", "--state", "all", "--json", "assignees", "--limit", "100"]
        res = subprocess.run(cmd, cwd=REPO_ROOT, capture_output=True, text=True, timeout=10)
        if res.returncode == 0:
            issues = json.loads(res.stdout)
            for issue in issues:
                for assignee in issue.get("assignees", []):
                    login = assignee.get("login", "")
                    if login in counts:
                        counts[login] += 1
                    else:
                        normalized = normalize_author(login, "")
                        if normalized in counts:
                            counts[normalized] += 1
            return counts
    except Exception:
        pass

    return counts


def calculate_upper_bound(values, min_bound=10):
    """Compute clean y-axis ceiling rounded to a readable multiple."""
    max_val = max(values) if values else 0
    if max_val <= 0:
        return min_bound
    # Round up to a pleasant interval
    if max_val <= 10:
        return 10
    if max_val <= 50:
        return ((max_val // 10) + 1) * 10
    if max_val <= 500:
        return ((max_val // 50) + 1) * 50
    return ((max_val // 200) + 1) * 200


MERMAID_INIT = '%%{init: {"themeVariables": {"xyChart": {"plotColorPalette": "#e91e63, #2563eb"}}}}%%\n'


def render_timeline_chart(title: str, y_label: str, weeks: list, series_by_author: dict) -> str:
    """Format Mermaid xychart-beta for timeline metrics."""
    x_labels = [f'"{w}"' for w in weeks]
    x_axis_str = f'[{", ".join(x_labels)}]'

    all_vals = []
    lines = []
    for author in TRACKED_AUTHORS:
        vals = [series_by_author.get(w, {}).get(author, 0) for w in weeks]
        all_vals.extend(vals)
        lines.append(f"    line [{', '.join(str(v) for v in vals)}]")

    max_bound = calculate_upper_bound(all_vals)

    chart = (
        MERMAID_INIT +
        f'xychart-beta\n'
        f'    title "{title}"\n'
        f'    x-axis {x_axis_str}\n'
        f'    y-axis "{y_label}" 0 --> {max_bound}\n'
        + "\n".join(lines)
    )
    return chart


def render_bar_chart(title: str, y_label: str, counts_by_author: dict) -> str:
    """Format Mermaid xychart-beta with dedicated series per contributor for distinct colors."""
    x_labels = [f'"{author}"' for author in TRACKED_AUTHORS]
    vals = [counts_by_author.get(author, 0) for author in TRACKED_AUTHORS]
    max_bound = calculate_upper_bound(vals, min_bound=5)

    bar_lines = []
    for i, author in enumerate(TRACKED_AUTHORS):
        author_val = counts_by_author.get(author, 0)
        slot_vals = [author_val if j == i else 0 for j in range(len(TRACKED_AUTHORS))]
        bar_lines.append(f'    bar [{", ".join(str(v) for v in slot_vals)}]')

    chart = (
        MERMAID_INIT +
        f'xychart-beta\n'
        f'    title "{title}"\n'
        f'    x-axis [{", ".join(x_labels)}]\n'
        f'    y-axis "{y_label}" 0 --> {max_bound}\n'
        + "\n".join(bar_lines)
    )
    return chart


def main():
    SNIPPETS_DIR.mkdir(parents=True, exist_ok=True)

    weeks, commits, additions, deletions = get_git_log_data()
    issue_counts = get_issue_counts()

    # Generate charts
    velocity_chart = render_timeline_chart(
        "Commits per Contributor over Timeline",
        "Commits",
        weeks,
        commits,
    )
    additions_chart = render_timeline_chart(
        "Lines Added per Contributor over Timeline",
        "Lines Added",
        weeks,
        additions,
    )
    deletions_chart = render_timeline_chart(
        "Lines Removed per Contributor over Timeline",
        "Lines Removed",
        weeks,
        deletions,
    )
    issues_chart = render_bar_chart(
        "Issues Assigned per Contributor",
        "Issues",
        issue_counts,
    )

    # Write files
    (SNIPPETS_DIR / "commit-velocity.mmd").write_text(velocity_chart + "\n")
    (SNIPPETS_DIR / "code-additions.mmd").write_text(additions_chart + "\n")
    (SNIPPETS_DIR / "code-deletions.mmd").write_text(deletions_chart + "\n")
    (SNIPPETS_DIR / "assigned-issues.mmd").write_text(issues_chart + "\n")

    print(f"Updated metrics snippets in {SNIPPETS_DIR}")
    print(f"Timeline weeks: {weeks}")
    print(f"Tracked authors: {TRACKED_AUTHORS}")


if __name__ == "__main__":
    main()
