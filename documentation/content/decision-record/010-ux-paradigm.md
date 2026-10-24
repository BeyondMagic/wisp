---
icon: lucide/workflow
---

<!-- markdownlint-disable MD033 -->

# 010: UX Paradigm and Interaction Flows

- **Type:** Design
- **Status:** Proposed
- **Date:** 2026-10-10
- **Author(s) / Deciders:** João V. Farias
- **Question:** What interaction paradigm (intuitive and familiar versus innovative and performance-driven) governs user workflows and interface ergonomics?

## Context

User experience design requires choosing whether to conform to established platform heuristics or introduce a novel mental model. An intuitive interface lowers onboarding friction by leveraging transferred domain knowledge, whereas innovative interaction grammars (such as modal editing, command palettes, or spatial node graphs) require deliberate training but unlock superior operational throughput for power users.

**What triggers a feature?**: a frustrated user or a need for a faster workflow.

## Comparative Paradigm Trade-off Matrix

<span class="md-typeset-planned">Evaluate the candidate interaction paradigms against project user needs:</span>

| Criterion | Intuitive / Familiar Paradigm | Innovative / Novel Paradigm | Hybrid (Progressive Disclosure) |
| :--- | :--- | :--- | :--- |
| **Mental Model** | Standard platform conventions (nested menus, standard forms, point-and-click). | Specialized interaction grammar (modal states, command palettes, spatial canvases). | Familiar point-and-click baseline with keyboard overlay shortcuts. |
| **Learning Curve** | Near zero. Relies on transfer of learning from common applications. | Moderate to steep. Requires explicit tutorials, tooltips, or muscle memory. | Gradual. New users use standard UI; advanced users learn shortcuts over time. |
| **Throughput Ceiling** | Moderate. Limited by mouse travel, multiple dialog clicks, and menu depth. | Maximum. High-density, keyboard-driven actions execute at command speed. | High. Everyday tasks are accessible; repetitive tasks execute via quick actions. |
| **Error Tolerance** | High. Visual confirmation dialogs, cancel buttons, and breadcrumb navigation. | Requires robust undo/redo history and non-destructive execution models. | High. Standard visual guards with rapid keyboard undo mechanisms. |

## Requirements and Restrictions

### Interaction Philosophy

- **Action Labels vs. Visual Status:** The button label communicates the state the system will move to; we tend to see color and icons as status, not actions. That is how objects in the physical world work: if the stove is red, it is hot right now, not in the future.
- **Transferred Knowledge over "Pure Intuition":** True intuition is a myth; everything becomes learned behavior. However, using existing paradigms saves users time and effort.
- **Familiarity Baseline:** Familiarity is key; interactions SHOULD resemble established physical or digital patterns where possible.
- **Learning vs. Capability:** The goal MUST NOT be to completely eliminate the need for learning, as learning never truly disappears. Never sacrifice new paradigms that are more capable, efficient, and effective solely for the sake of familiarity.
- <span class="md-typeset-planned">**Primary Input Modality:** Define the primary navigation method (keyboard-first, pointer-driven, CLI commands, or touch gestures).</span>

### Feedback and Ergonomics

- <span class="md-typeset-planned">**Response Feedback:** Specify expected state transition cues (visual loaders, optimistic UI updates, or immediate terminal prompts).</span>
- <span class="md-typeset-planned">**Error Recovery:** Define the undo/redo model, rollback affordances, and destructive action confirmations.</span>
- <span class="md-typeset-planned">**Information Density:** Determine the density level (compact data tables, spacious card layouts, or customizable workspace panels).</span>

### Traceability to Feature Records

- Detailed interaction steps, screen wireframes, and use-case flows for specific features MUST be documented in individual [Feature Records](../feature-record/index.md).

## Alternatives

- <span class="md-typeset-planned">**Strict Conventional Point-and-Click:** Maximizes immediate discoverability but constrains expert workflow speed and repetitive data entry.</span>
- <span class="md-typeset-planned">**Pure Power-User Modal Interface:** Delivers maximum density and operational velocity but risks high user abandonment without guided onboarding.</span>
- <span class="md-typeset-planned">**Hybrid Progressive Disclosure:** Balances casual onboarding with expert efficiency, but increases frontend state complexity and maintenance scope.</span>

## Decision

<span class="md-typeset-planned">State the chosen interaction paradigm, primary input modality, and core ergonomic principles governing application workflows.</span>

## Consequences

### Positives

- <span class="md-typeset-planned">Clear consensus on whether to optimize for immediate discoverability or expert execution speed.</span>
- <span class="md-typeset-planned">Consistent mental model prevents conflicting interaction patterns across distinct features.</span>

### Negatives

- <span class="md-typeset-planned">Choosing a novel paradigm requires investing in onboarding documentation, shortcut cheatsheets, and guided tours.</span>
