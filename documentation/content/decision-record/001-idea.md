---
icon: lucide/lightbulb
---

<!-- markdownlint-disable MD033 -->

# 001: Project Idea and Scope

- **Type:** Product
- **Status:** Proposed
- **Date:** 2026-10-03
- **Author(s) / Deciders:** João V. Farias
- **Question:** What problem does this project solve, for whom, and what is explicitly in or out of scope?

## Context

This project is a desktop shell for Wayland, built with [Quickshell](https://quickshell.org/) and designed to run alongside [Hyprland](https://hypr.land/). It replaces my earlier shell built with [Aylur's GTK Shell (AGS)](https://aylur.github.io/ags/). While the old shell worked for daily use, it grew organically without structured design rules or interaction specifications. This rewrite restarts the project on Quickshell with a cleaner architecture, better performance, and a consistent visual style.

<span class="md-typeset-planned">Refine the problem statement, user personas, and explicit scope boundaries as requirements mature.</span>

## Requirements and Restrictions

- **Target Users:** Personal daily driver and Wayland/Hyprland desktop users seeking a minimalist, high-contrast widget and shell platform.
- **In Scope:** System boot splash ([001: Plymouth](../feature-record/001-plymouth.md)), display manager authentication ([002: Login](../feature-record/002-login.md)), desktop bars and trays, application launcher, workspace overview, notifications, time/habit/task tracking, media controls, OCR, and service management.
- **Out of Scope:** <span class="md-typeset-planned">Capabilities intentionally excluded to prevent scope creep (for example, window management logic handled directly by the Wayland compositor).</span>
- **Environment / Platform:** Linux with Wayland ([Hyprland](https://hypr.land/)) and [Quickshell](https://quickshell.org/).

## Alternatives

- **Continuing with Aylur's GTK Shell (AGS):** Kept the existing codebase working, but suffered from ad-hoc architecture and lack of structured interaction specifications.
- **Off-the-Shelf Desktop Panels (Waybar, Rofi, Dunst):** Require stitching together disparate configuration formats, styling rules, and IPC scripts without unified state or visual hierarchy.

## Decision

Build a unified, modular desktop shell and widget platform on Quickshell for Hyprland, where every feature is specified through interaction flows and visual designs before code implementation.

## Consequences

### Positives

- Clear boundaries and specification-first development keep components focused on primary desktop workflows.
- Unified runtime and design tokens across all panels, overlays, and widgets.

### Negatives

- Excluded compositor-level features must be configured in Hyprland or external system daemons.
