---
icon: lucide/chart-line
---

<!-- markdownlint-disable MD033 -->

# Project Measurement and Metrics

Software measurement connects project activities to objective decision-making. Following the Practical Software Measurement (PSM) framework and ISO/IEC 15939 measurement process, this page provides a quantitative view of development progress, code stability, and workload distribution.

## Measurement Scope and Filters

- **Start Date:** 2026-09-25
- **End Date:** Current (`HEAD`)

### Tracked Contributors

| Contributor | Visual Identifier | Graph Series | Commit History |
| :--- | :--- | :--- | :--- |
| <img src="https://avatars.githubusercontent.com/u/51831435?v=4" width="24" height="24" style="border-radius: 50%; vertical-align: middle; margin-right: 6px;" alt="BeyondMagic avatar"> **BeyondMagic** | <span style="display:inline-block;width:12px;height:12px;border-radius:50%;background-color:#e91e63;vertical-align:middle;margin-right:4px;"></span> `#e91e63` | Series 1 (Pink) | [View Commits](https://github.com/BeyondMagic/wisp/commits?author=BeyondMagic) |
| <img src="https://avatars.githubusercontent.com/in/15368?v=4" width="24" height="24" style="border-radius: 50%; vertical-align: middle; margin-right: 6px;" alt="github-actions[bot] avatar"> **github-actions[bot]** | <span style="display:inline-block;width:12px;height:12px;border-radius:50%;background-color:#2563eb;vertical-align:middle;margin-right:4px;"></span> `#2563eb` | Series 2 (Blue) | [View Commits](https://github.com/BeyondMagic/wisp/commits?author=github-actions%5Bbot%5D) |

## Code Activity and Churn

These measures track development cadence and code volume changes across the project timeline.

### Commit Velocity

Measures the number of commits submitted by each contributor across successive milestones or time intervals.

```mermaid
--8<-- "management/commit-velocity.mmd"
```

### Code Additions

Measures the volume of new lines introduced by each author over the observation period. Spikes in additions often coincide with initial feature scaffolding.

```mermaid
--8<-- "management/code-additions.mmd"
```

### Code Deletions

Measures lines removed by each author. Consistent deletions alongside additions indicate refactoring and technical debt reduction rather than pure accretion.

```mermaid
--8<-- "management/code-deletions.mmd"
```

## Workload and Responsibility

This section monitors task distribution across contributors to ensure balanced ownership and prevent single points of failure.

### Assigned Issues by Contributor

Measures the quantity of tasks or issue tickets assigned to each team member.

```mermaid
--8<-- "management/assigned-issues.mmd"
```

## Automation Strategy

These metrics are structured for automated generation:

1. **Git Data Extraction:** A Python script parses `git log --numstat` between the configured start and end dates, calculating commit counts and line diffs per author.
2. **Deterministic Styling:** Each contributor username maps to a deterministic hex color, ensuring visual consistency across all charts.
3. **CI Pipeline Integration:** The extraction script runs during automated documentation builds and on git commit hooks, keeping the Mermaid charts up to date without manual editing.

