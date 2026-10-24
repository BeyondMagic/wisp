---
icon: lucide/bot
---

<!-- markdownlint-disable MD033 -->

# 008: AI Usage Policy

- **Type:** Social
- **Status:** Proposed
- **Date:** 2026-10-18
- **Author(s) / Deciders:** João V. Farias
- **Question:** Under what conditions may generative AI tools and coding agents be used to contribute to this repository?

## Context

Generative AI tools and coding agents can accelerate research, scaffolding, documentation, and implementation. However, unsupervised AI output introduces subtle bugs, bloated prose, unverified claims, and review burden for maintainers. Clear accountability rules ensure AI assistance improves productivity without lowering engineering standards.

## Requirements and Restrictions

- **Human Accountability:** Every contribution must have a human author who understands, verifies, and takes full responsibility for the changes.
- **Transparency:** AI tool usage and model/provider details must be disclosed in commits or pull requests.
- **Quality Parity:** AI-assisted code and documentation must meet the exact same review, testing, and [`humanizer`](./003-writing-style.md) standards as manually written work.

## Alternatives

- **Prohibit All AI Tools:** Banning AI assistance entirely forfeits productivity gains in boilerplate generation, refactoring, and structured requirements interviews.
- **Unrestricted / Unsupervised AI Usage:** Allowing unreviewed AI dumps shifts the verification burden onto maintainers and degrades codebase coherence.

## Decision

The use of generative AI tools is allowed under the following conditions:

- The use of AI tools **MUST** be declared (for example, in the PR description or via dedicated commit trailers/co-authors).
- The specific AI tool and model/provider **SHOULD** be declared.
- AI tools **MUST** operate under the supervision of a human contributor who is accountable for every line submitted.
- The use of AI tools does **NOT** lower the quality threshold of any contribution.
- Contributors **MUST NOT** act as a ["meat-proxy"](https://dontbeameatproxy.com/) (copy-pasting automated output or review responses without understanding and validating them).
- Respect maintainer time by ensuring all AI-assisted contributions are tested, concise, and genuinely valuable.

### Prompt Checklist

For every agent session or prompt on this repository, the agent MUST:

1. Follow `AGENTS.md` at the repository root, including the `humanizer` writing rules and `zensical-glossary` conventions.
2. Consult relevant [Decision Records](./index.md) and [Feature Records](../feature-record/index.md) before proposing architectural or behavioral changes.
3. Verify documentation changes with `zensical build --clean` and code changes with the project's test suite before completion.

## Consequences

### Positives

- Maintainers can trust that contributors understand and stand behind their submissions.
- Coding agents follow consistent repository rules (`AGENTS.md`, `grill-me`, `humanizer`).

### Negatives

- Contributors must spend time reviewing, trimming, and testing AI-generated output before opening a pull request or committing.
