---
icon: lucide/list-checks
---

<!-- markdownlint-disable MD033 -->

# 006: Requirements

- **Type:** Product
- **Status:** Accepted
- **Date:** 2026-10-03
- **Author(s) / Deciders:** João V. Farias
- **Question:** What functional and non-functional requirements MUST the system satisfy, and how are they traced to features?

## Context

In my previous shell, widgets and features were built ad-hoc. I often started by writing code directly, which meant figuring out interaction rules and visual layouts halfway through implementation. That led to wasted effort, awkward edge cases, and having to rewrite components after discovering that a flow did not work well in practice.

For this rewrite in Quickshell, I want a disciplined requirements and feature engineering workflow. Deciding how a user interacts with a feature before writing code keeps components focused, prevents bloated widgets, and ensures visual designs match actual use cases. Individual feature workflows are broken out into dedicated [Feature Records](../feature-record/index.md).

## Requirements and Restrictions

### Feature Engineering Workflow

- **FR-01 (Interaction Flow First):** Every feature specification MUST begin with the user interaction flow written step-by-step in a use-case format, following [010: UX Paradigm and Flows](./010-ux-paradigm.md).
- **FR-02 (Visual Design Second):** Once the interaction flow is settled, the feature MUST be translated into Figma wireframes or mockups following the visual design rules in [009: Visual Identity and UI](./009-visual-identity.md).
- **FR-03 (Implementation Plan Third):** Each feature specification MUST outline technical details, required Quickshell or QtQuick APIs, external system tools, and performance budgets before implementation begins.
- **FR-04 (Feature Record Traceability):** Every feature MUST be documented inside `documentation/content/feature-record/` using the `XXX-feature-name.md` (or `XXX-feature-name/index.md`) naming format, following the [Feature Record Template](../feature-record/000-template.md).

### Non-Functional Requirements

- <span class="md-typeset-planned">**NFR-01 (Performance):** Target frame latency, startup time, and memory budget for persistent background panels and popups.</span>
- <span class="md-typeset-planned">**NFR-02 (Security & Privacy):** Local data handling, credential prompts, and sandboxing constraints.</span>
- <span class="md-typeset-planned">**NFR-03 (Portability):** Supported Linux distributions, Wayland compositors, and Quickshell runtime versions.</span>

## Alternatives

- **Ad-Hoc Code-First Development:** Starting directly in code without specifying interaction flows or visual mockups led to repeated rewrites and inconsistent widget ergonomics in the previous shell.
- **Informal Issue Tracking Only:** Tracking requirements solely in ad-hoc issue tickets makes system-wide constraints and [RFC 2119](../glossary.md) invariants hard to audit.

## Decision

Adopt a three-stage specification workflow for all features and widgets, tracked in the [Feature List](../feature-record/index.md):

1. **Interaction flow:** Document the complete user flow in `documentation/content/feature-record/XXX-feature-name.md` following [010: UX Paradigm](./010-ux-paradigm.md).
2. **Visual design:** Create Figma wireframes or mockups that fit the steps and follow [009: Visual Identity](./009-visual-identity.md).
3. **Implementation plan:** Outline the required Quickshell/QtQuick APIs, external system tools, and performance limits.
4. **Lifecycle tracking:** Each feature starts as **Planned** or **Proposed**. Code development begins only after the flow and design are settled and marked as **Accepted** in the [Feature List](../feature-record/index.md).

## Consequences

### Positives

- Planning the interaction flow first prevents rewriting code when edge cases appear.
- UI components stay consistent because mockups follow settled user steps instead of guesswork.
- Technical constraints and missing dependencies are caught before implementation begins.
- Clear traceability between high-level project scope ([001: Idea](./001-idea.md)), quality priorities ([005: Quality Factors](./005-quality-factors.md)), and individual features.

### Negatives

- Small adjustments and quick experiments take longer because of the upfront specification step.
- Feature records must be kept up to date as components evolve over time.
