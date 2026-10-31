---
icon: lucide/timer
---

<!-- markdownlint-disable MD033 -->

# 006.3: Focus Timer

- **Status:** <span class="md-typeset-planned">Proposed</span>
- **Date:** 2026-10-31
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

A clock, timer, and Pomodoro widget directly connected to [006.2: Habit & Task Tracker](./002-habit-tracker.md) and [006.4: Daily Tasks](./004-daily-tasks.md). Starting a task transitions the widget into Focus Mode and tracks the elapsed time spent on that task.

<!--
Specifications:
- Container Geometry (matches 006.1 Calendar):
  - Outer Frame: 330px wide, #09090b fill, 5px corner radius, 10px padding.
  - Inner Frame: 310px wide, 1px inside stroke rgba(250, 250, 250, 0.05), 25px padding (260px content width), 12px vertical spacing.
- Minimal Analog Clock Dial (200x200 centered inside the 260px content area):
  - No outer ring or tick marks; strictly the 12 hour numbers (`1`..`12`) arranged radially (`Inter` Regular 12px, #fafafa at 60% opacity; `12`, `3`, `6`, `9` in `Inter` Medium 12px #fafafa), a central 6x6 dot (#60cdea), and 3 straight lines:
    - Hour hand: 2px wide, #fafafa
    - Minute hand: 1.5px wide, #fafafa
    - Second hand: 1px wide, #60cdea
- Modes (2 Figma frames):
  1. Idle Clock Mode: Minimal analog dial on top, separated by a 1px horizontal divider rgba(250, 250, 250, 0.05) from a compact bottom row with quick action buttons to start a standalone Focus timer or 25m Pomodoro session.
  2. Active Task Focus Mode: Minimal analog dial on top, separated by a 1px horizontal divider from the active task panel showing:
     - Active task title (`Inter` Medium 12px, #fafafa) + mode/category subtitle (`Inter` Regular 11px, rgba(250, 250, 250, 0.40)).
     - Digital elapsed time counter (`Gued` Bold 24px, #60cdea, e.g. `00:42:18`) + Pause/Resume and Complete/Stop icon buttons.
- Backend Integration: Starting a task from 006.4 (Daily Tasks) switches this widget into Active Task Focus Mode. Stopping or completing logs the tracked duration to the shared local cache and syncs with Google Calendar (`calendar3.nu`), updating 006.2 (Habit & Task Tracker) and 006.4 (Daily Tasks).
-->

## Benchmark

<span class="md-typeset-planned">Provide examples of focus timers and task-linked Pomodoro counters.</span>

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow for switching between clock, Pomodoro, and task-linked focus mode.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the clock, timer, and focus mode states in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe the timer state machine and how task duration logs sync back to `calendar3.nu`.</span>

