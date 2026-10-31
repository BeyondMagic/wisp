---
icon: lucide/layout-grid
---

<!-- markdownlint-disable MD033 -->

# 006: Widgets

- **Status:** <span class="md-typeset-planned">Proposed</span>
- **Date:** 2026-10-31
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

Desktop widgets sit directly over the wallpaper on the Wayland `WlrLayer.Bottom` layer. Normal tiled and floating windows cover them during active work, while empty workspaces expose them for interactive time tracking, schedule inspection, and habit review.

<!--
Specifications:
- Layer: WlrLayerShell `WlrLayer.Bottom` with `ExclusionMode.Ignore`, positioned over the wallpaper so application windows naturally occlude them.
- Data Synchronization: Shared local state cache in Quickshell synced asynchronously with Google Calendar via `calendar3.nu`. Starting or completing a task immediately updates the Daily Tasks list, Focus Timer, and Habit & Task Tracker heatmap without waiting for network round-trips.
- Inter-Widget Link: Selecting "Start" on a task in 006.4 (Daily Tasks) transitions 006.3 (Focus Timer) into active Focus Mode and logs completion metrics into 006.2 (Habit & Task Tracker).
-->

## Widgets

| ID    | Widget                                         | Role                                                                                   | Backend / Source                  | Status   |
| :---- | :--------------------------------------------- | :------------------------------------------------------------------------------------- | :-------------------------------- | :------- |
| 006.1 | [Calendar](./001-calendar.md)                  | Minimal monthly calendar grid without the legacy agenda sidebar                        | Local `Date`                      | Proposed |
| 006.2 | [Habit & Task Tracker](./002-habit-tracker.md) | 7-day by 12-month contribution heatmap with category filter                            | Local cache + `calendar3.nu`      | Proposed |
| 006.3 | [Focus Timer](./003-focus-timer.md)            | Clock, timer, and Pomodoro counter that enters focus mode when a task starts           | Local state + `calendar3.nu`      | Proposed |
| 006.4 | [Daily Tasks](./004-daily-tasks.md)            | Super Productivity-style day view split into Passed, Later Today, and Completed tasks  | Local cache + `calendar3.nu`      | Proposed |

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow between desktop wallpaper widgets, focus tracking, and Google Calendar synchronization.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups and layout coordinates in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe the `WlrLayer.Bottom` window arrangement and shared Google Calendar cache service.</span>
