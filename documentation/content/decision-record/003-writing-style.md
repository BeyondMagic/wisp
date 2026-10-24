---
icon: lucide/pen-tool
---

<!-- markdownlint-disable MD033 -->

# 003: Writing Style

- **Type:** Social
- **Status:** Accepted
- **Date:** 2026-10-24 (Initial: 2026-10-18)
- **Author(s) / Deciders:** João V. Farias
- **Question:** Who are we writing this documentation for, and what writing rules govern all project texts?

## Context

Documentation fails when it hides the point behind inconsistent terms, repeated inline explanations, or recognizable AI filler. In a solo project maintained alongside AI coding agents, vague or bloated prose quickly compounds: future me has to re-parse what a component was supposed to do, and coding agents copy bad habits into new pages and comments.

I want every text in the repository to state facts directly so the reader spends minimal effort parsing the prose.

## Requirements and Restrictions

- **Target Audience:** Primary readers are myself (for future maintenance) and AI coding agents operating in the repository. Secondary readers are Linux and Wayland developers inspecting, learning from, or forking the codebase.
- **Scope and Language:** Rules apply to all repository text, including Markdown pages (`documentation/` and `README.md`), source code comments and docstrings, and Git commit messages, written in US English.
- **Voice:** First-person singular ("I") is appropriate when recording personal context, trade-offs, and motivation in decision records. Specifications and behavior rules use direct imperative statements and normative keywords.
- **Normative Precision:** Specifications must distinguish hard requirements from preferences without ambiguity.
- **No Inline Over-Explanation:** Domain and technical terms should not be repeatedly defined mid-paragraph.
- **Human Voice:** Prose must avoid formulaic AI sentence structures and filler vocabulary.

## Alternatives

- **Unconstrained Ad-Hoc Prose:** Letting each session or LLM prompt dictate tone leads to uneven quality, synonym cycling, and verbose paragraphs.
- **Strictly Impersonal Corporate Tone:** Writing every decision record in passive third-person ("it was decided by the team") feels artificial for a personal project and obscures my actual reasoning.
- **Inline Definitions Everywhere:** Explaining domain concepts repeatedly inside paragraphs clutters the reading flow and causes definitions to drift out of sync across pages.

## Decision

All documentation, code comments, and commit messages in this repository MUST follow these rules:

1. **Voice and Directness:** Put the message ahead of decorative form. Use first-person ("I") for personal design rationale and direct, factual prose for technical specifications.
2. **Normative Keywords:** Interpret "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" according to [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119.txt).
3. **Standard Terminology via Glossary:** Use established technical terms. Define recurring domain and project terms once in the [Glossary](../glossary.md) (at `### Term` level) or via `<!-- zensical-glossary: Term -->` inline markers so `zensical-glossary` renders tooltips automatically instead of repeating definitions in prose.
4. **Humanizer Compliance:** Apply the repository's `humanizer` rules to all text:
   - Use straight quotes and apostrophes only. Never use em dashes or double hyphens.
   - State points directly. Avoid contrastive reframing ("it's not X, it's Y"), negative parallelism ("not only... but also"), rule-of-three padding, copula avoidance ("serves as"), and superficial `-ing` tails.
   - Do not invent statistics, benchmarks, or anecdotes.
5. **Commit Messages:** Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) in lowercase imperative mood with headers under 50 characters.

## Consequences

### Positives

- Documentation stays short, scannable, and consistent across both manual edits and AI-assisted sessions.
- Centralizing definitions in the [Glossary](../glossary.md) keeps paragraphs tight while giving external readers immediate context through tooltips.
- Allowing first-person voice in decision records keeps the reasoning honest without weakening the precision of RFC 2119 specifications.

### Negatives

- Both I and any coding agent working in the repository must run a quality-control pass against the `humanizer` and glossary rules before committing changes.
