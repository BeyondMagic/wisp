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

Minimalist Wayland window managers deliberately omit a desktop shell. To get a working desktop, users stitch together separate programs for the status bar, application launcher, notification daemon, power menu, and screen locker. Each program has its own configuration syntax, styling rules, and background polling scripts. Keyboard navigation changes from one popup to the next, and the desktop never quite feels like a single system.

I previously built a custom desktop shell for my own daily use to put all of those pieces in one place. While it worked, I kept adding widgets and side projects as I went without defining where the shell ended and standalone applications began. Over time, the codebase became hard to maintain.

This project is a clean-slate rewrite to build a cohesive desktop shell with strict boundaries: handle core desktop chrome, session controls, and scriptable quick actions in one process, and leave full applications out of the shell.

## Requirements and Restrictions

- **Target Users:** Built first for my own daily desktop workflow on Linux, while kept public so other Wayland users can inspect, fork, or adapt it.
- **In Scope:**
  - In-session screen locking and user authentication;
  - Session power controls and battery/power state reporting;
  - Persistent top-bar panels for system status (audio, network, clock, tray icons, active media playback controls) and workspace navigation;
  - Desktop notification popups and history;
  - Spatial overview of active workspaces and windows;
  - A keyboard-driven launcher for opening applications and running shell scripts (such as service toggles, clipboard OCR, or quick calculations).
- **Out of Scope:**
  - Window management, tiling layouts, and display compositing (delegated to the Wayland compositor);
  - Early-boot splash screens that run in `initramfs` before the graphical session starts;
  - Standalone CRUD applications or databases (such as dedicated time, habit, or task trackers, or full music library clients);
  - User-customizable theme engines, GUI skin editors, or third-party plugin marketplaces;
  - X11 compatibility.
- **Environment / Platform:** Linux on Wayland.

## Alternatives

- **Keep maintaining the old shell:** Avoids starting over, but keeps the accumulated technical debt and ad-hoc structure that made the previous version fragile.
- **Stitch together standard Wayland utilities (`waybar`, `rofi`, `dunst`, `swaylock`):** Takes less custom UI code, but goes back to maintaining separate config files, duplicated status scripts, and inconsistent keyboard shortcuts.
- **Use a full desktop environment (GNOME, KDE Plasma):** Gives a unified interface out of the box, but brings along a heavy service stack and floating-window defaults that do not fit a keyboard-first tiling setup.
- **Build an all-in-one desktop and productivity suite:** Putting personal trackers, media clients, and boot themes inside the shell repository stretches the project beyond a desktop shell and makes it impossible to finish cleanly.

## Decision

Build a focused, personal-first desktop shell for Wayland that unifies session locking, status bars, notifications, window overview, and a scriptable command launcher into a single runtime.

If a workflow can be solved by a shell script or an external CLI tool, the shell will only provide the launcher entry or status indicator for it rather than reimplementing a dedicated GUI application.

## Consequences

### Positives

- Clear scope boundaries prevent the shell from turning into a collection of half-finished productivity apps.
- Every desktop overlay and bar shares the same process, state, and keyboard behavior.
- Relying on shell scripts for secondary utilities (like OCR, calculators, or service toggles) keeps the UI layer small.

### Negatives

- Anything outside desktop chrome (such as task tracking, habit logging, or music library management) must be handled by separate CLI or desktop programs.
- Tailoring the shell to a single personal workflow means other users will likely need to edit the source code rather than toggling settings in a preferences window.
