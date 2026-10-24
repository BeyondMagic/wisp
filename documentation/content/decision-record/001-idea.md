---
icon: lucide/lightbulb
---

<!-- markdownlint-disable MD033 -->

# 001: Project Idea and Scope

- **Type:** Product
- **Status:** Accepted
- **Date:** 2026-10-24 (Initial: 2026-10-03)
- **Author(s) / Deciders:** João V. Farias
- **Question:** What problem does this project solve, for whom, and what is explicitly in or out of scope?

## Context

Wayland users on tiling compositors such as [Hyprland](https://hypr.land/) typically build a desktop environment by stitching together independent utilities: a status bar (`waybar`), an application launcher (`rofi` or `fuzzel`), a notification daemon (`dunst` or `mako`), and a screen locker (`hyprlock` or `swaylock`). Each utility uses its own configuration format, styling system, and IPC polling loop, resulting in fragmented keyboard navigation, visual inconsistency, and duplicated system state.

My previous desktop shell (`lovemii`), built with [Aylur's GTK Shell (AGS)](https://aylur.github.io/ags/), consolidated these tools into a single runtime for daily use. However, it grew organically without upfront design tokens, interaction flows, or strict scope boundaries. `WISP` (**Widget Interface & Shell Platform**) restarts the project on [Quickshell](https://quickshell.org/) with a specification-first workflow, lower runtime overhead, and a unified monochrome visual identity, constrained strictly to what can be built cleanly with Quickshell (Qt6/QML) and shell scripting.

## Requirements and Restrictions

- **Target Users:** Personal-first daily driver tailored to the author's desktop workflow, published under `AGPL-3.0-or-later` with complete architectural and feature records so other Hyprland and Quickshell users can study, fork, or adapt it.
- **In Scope:** Core desktop shell chrome, session lock/authentication, and script-backed launcher utilities across seven features:
  1. [001: Login](../feature-record/001-login.md): Session authentication and lockscreen (`WlSessionLock`, PAM, and `fprintd` fingerprint support).
  2. [002: Power Management](../feature-record/002-power-management.md): Session power actions (lock, suspend, reboot, poweroff) and power profile / battery status (`UPower`).
  3. [003: System Tray](../feature-record/003-system-tray.md): Top-bar status indicators (PipeWire audio, network, clock, `StatusNotifierItem` tray icons) and an integrated `Mpris` media playback control popup.
  4. [004: Workspace Tray](../feature-record/004-workspace-tray.md): Hyprland workspace indicator and active workspace navigation.
  5. [005: Notifications](../feature-record/005-notifications.md): Desktop notification daemon, toast popups, and notification history.
  6. [006: Overview](../feature-record/006-overview.md): Spatial workspace and window overview for Hyprland.
  7. [007: Launcher](../feature-record/007-launcher/index.md): Keyboard-driven application launcher and extensible script command palette (handling local `dinit`/`systemd` and remote Tailscale SSH service toggles, `grim` + `tesseract`/`RapidOCR` screen OCR, `qalculate` math evaluation, dictionary lookups, and emoji selection).
- **Out of Scope:**
  - Early-boot kernel splash themes (`Plymouth`), which execute in `initramfs` outside Wayland and Quickshell.
  - Standalone personal productivity CRUD applications (dedicated time, habit, or task tracker GUIs).
  - Full media streaming or library management clients (media integration is limited to MPRIS playback controls inside [003: System Tray](../feature-record/003-system-tray.md)).
  - Standalone GUI windows for single-command scripts such as screen OCR or service toggling (handled as script-backed command providers inside [007: Launcher](../feature-record/007-launcher/index.md)).
  - Window management, tiling layout algorithms, and display compositing (delegated to Hyprland).
  - X11 support or compatibility layers for non-Hyprland Wayland compositors (`sway`, `niri`, KDE, GNOME).
  - Runtime theme engines, user-customizable color schemes, or CSS skinning (visual tokens are fixed in [009: Visual Identity](./009-visual-identity.md)).
  - Third-party plugin loading or external extension marketplaces.
- **Environment / Platform:** Linux on Wayland with [Hyprland](https://hypr.land/) as the compositor, [Quickshell](https://quickshell.org/) (Qt6/QML) as the shell runtime, and standard POSIX/CLI scripts via `Quickshell.Io.Process`.

## Alternatives

- **Continuing with Aylur's GTK Shell (AGS):** Preserved the working `lovemii` codebase, but carried accumulated technical debt from ad-hoc feature growth, lacked formal UX specifications, and had higher resource overhead than Qt6/QML scenegraph rendering.
- **Assembling Off-the-Shelf Utilities (Waybar, Rofi, Dunst, hyprlock):** Reduces custom UI code for basic bars and menus, but requires maintaining disparate configuration DSLs, shell scripts, and styling rules without shared state or unified keyboard navigation.
- **Bloated All-in-One Shell Suite (Including Custom Trackers, Boot Splash, and Media Clients):** Attempting to build full CRUD productivity trackers, a Navidrome/Jellybox music client, and an `initramfs` Plymouth theme inside the shell repository introduces severe scope creep and stretches QML beyond desktop chrome and scripting.

## Decision

Build `WISP` as a focused, personal-first desktop shell on Quickshell for Hyprland, scoped strictly to session locking, persistent bar trays, notifications, spatial overview, and a script-extensible command launcher (`001` through `007`).

Workflow automations such as screen OCR, local/Tailscale service toggles, and quick calculations MUST be implemented as CLI script pipelines surfaced through [007: Launcher](../feature-record/007-launcher/index.md) or [003: System Tray](../feature-record/003-system-tray.md) rather than standalone QML applications. Every feature MUST be specified in a [Feature Record](../feature-record/index.md) before implementation begins, as governed by [006: Requirements and Feature Engineering](./006-requirements.md).

## Consequences

### Positives

- Cutting non-Quickshell (`Plymouth`) and full-application features (`Time/Habit/Task Trackers`, `Music Manager`, standalone `OCR`/`Service Manager` GUIs) reduces the project from 14 disparate features to 7 cohesive desktop shell components.
- Folding OCR, service management, and calculations into [007: Launcher](../feature-record/007-launcher/index.md) and MPRIS into [003: System Tray](../feature-record/003-system-tray.md) preserves daily workflow utility using lightweight shell scripts.
- Keeps the entire codebase within a single technology boundary: Quickshell QML + Hyprland IPC + CLI scripts.

### Negatives

- Personal productivity tracking (time, habits, tasks) and full music library browsing must be handled by dedicated external applications or CLI tools rather than native shell widgets.
- Tight coupling to Hyprland IPC and a fixed visual design means users on other compositors or those wanting custom color themes must fork and modify the source code.
