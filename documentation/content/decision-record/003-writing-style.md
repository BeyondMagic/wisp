---
icon: lucide/pen-tool
---

<!-- markdownlint-disable MD033 -->

# 003: Writing Style

- **Type:** Social
- **Status:** Proposed
- **Date:** 2026-10-18
- **Author(s) / Deciders:** João V. Farias
- **Question:** Who are we writing this documentation for, and what writing rules govern all project texts?

## Context

Documentation fails when it obscures the core message behind inconsistent terminology, bloated explanations, or recognizable AI-generated filler. The priority of technical writing is the message being conveyed rather than decorative form. Every page should state facts directly so readers spend minimal effort parsing the prose.

## Requirements and Restrictions

- **Target Audience:** <span class="md-typeset-planned">Specify the primary readers of this project's documentation (for example, maintainers, external contributors, API consumers, or end users).</span>
- **Normative Precision:** Specifications must distinguish mandatory requirements from recommendations without ambiguity.
- **No Inline Over-Explanation:** Domain and technical terms should not be repeatedly defined mid-paragraph.
- **Human Voice:** Documentation must avoid formulaic AI patterns and padded phrasing.

## Alternatives

- **Unconstrained / Ad-Hoc Prose:** Letting each author or LLM prompt dictate tone leads to uneven quality, synonym cycling, and verbose explanations.
- **Inline Definitions Everywhere:** Explaining domain concepts repeatedly inside paragraphs clutters the reading flow and causes definitions to drift out of sync.

## Decision

All documentation and specifications in this repository MUST follow these rules:

1. **Normative Keywords:** Interpret "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" according to [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119.txt).
2. **Standard Terminology via Glossary:** Use established industry terms. Define domain and recurring project terms once in the [Glossary](../glossary.md) (at `### Term` level) or via `<!-- zensical-glossary: Term -->` inline markers so `zensical-glossary` provides tooltips automatically instead of repeating definitions inline.
3. **Humanizer Compliance:** Apply the project's `humanizer` rules to all prose:
   - Use straight quotes and apostrophes only; never use em dashes or double hyphens.
   - State points directly; avoid contrastive reframing ("it's not X, it's Y"), negative parallelism ("not only... but also"), copula avoidance ("serves as"), and superficial `-ing` tails.
   - Do not invent statistics, benchmarks, or anecdotes.

## Consequences

### Positives

- Documentation stays concise, scannable, and consistent across human and AI-assisted contributions.
- Centralizing definitions in the [Glossary](../glossary.md) keeps prose short while giving newcomers immediate context via tooltips.

### Negatives

- Contributors and coding agents must run a quality-control pass against the `humanizer` and glossary rules before submitting documentation changes.
