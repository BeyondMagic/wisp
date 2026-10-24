---
icon: lucide/network
---

<!-- markdownlint-disable MD033 -->

# 007: Architecture

- **Type:** Architecture
- **Status:** Proposed
- **Date:** 2026-10-03
- **Author(s) / Deciders:** João V. Farias
- **Question:** How is the system decomposed into components, data flows, and directory structures, and which diagrams document its design?

## Context

<span class="md-typeset-planned">Define the high-level system boundaries, technology stack, module layout under `source/`, and visual diagrams so contributors understand how data and control flow through the shell.</span>

## Required Visualizations

1. **UML Use-Case Diagram:** <span class="md-typeset-planned">Map actors to top-level system interactions.</span>
2. **Data-Flow Diagram (DFD):** <span class="md-typeset-planned">Trace how inputs are ingested, transformed, stored, and emitted across boundaries.</span>

### Optional Visualizations (If Necessary)

- **Class Diagram:** <span class="md-typeset-planned">Include when complex domain hierarchies or interface contracts need explicit visualization.</span>
- **Object Diagram:** <span class="md-typeset-planned">Include when runtime object graphs or ownership lifetimes require concrete snapshots.</span>

## Requirements and Restrictions

- **Tech Stack & Runtime:**
  - Shell engine: [Quickshell](https://quickshell.org/) (QtQuick / QML)
  - Wayland compositor: [Hyprland](https://hypr.land/)
- **Directory Layout:** <span class="md-typeset-planned">Organization of QML modules, services, and widgets inside `source/` and test suites under `tests/`.</span>
- **External Boundaries:** <span class="md-typeset-planned">Hyprland IPC sockets, D-Bus services (StatusNotifierItem, MPRIS, notifications, power management), and CLI helper processes.</span>

## Alternatives

- <span class="md-typeset-planned">**Aylur's GTK Shell (AGS) / Astal:** Used in the previous version of the shell; replaced by Quickshell for QtQuick scene-graph performance and reactive QML bindings.</span>
- <span class="md-typeset-planned">**Monolithic vs. Modular / Layered QML:** Compare architectural styles considered for organizing shell services and UI surfaces.</span>

## Decision

- Target [Quickshell](https://quickshell.org/) as the widget and shell runtime engine.
- Target [Hyprland](https://hypr.land/) as the Wayland compositor.
- <span class="md-typeset-planned">Describe the chosen module architecture under `source/` and embed the Mermaid UML Use-Case and Data-Flow diagrams below.</span>

## Consequences

### Positives

- <span class="md-typeset-planned">Visual diagrams and explicit module boundaries reduce onboarding time and prevent accidental coupling between UI panels and background services.</span>

### Negatives

- <span class="md-typeset-planned">Diagrams must be updated alongside structural refactors to prevent documentation drift.</span>
