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
- Modes:
  1. Clock / Idle Mode: Displays current time and quick controls to start a standalone timer or Pomodoro session.
  2. Focus / Task Timer Mode: Activated automatically when starting a task from 006.4 (Daily Tasks) or selecting a habit/task. Displays the active task title, elapsed time counter (or Pomodoro countdown), Pause/Resume, and Complete/Stop actions.
- Backend Integration: Stopping or completing a session logs the tracked duration and completion status to the shared local cache and syncs with Google Calendar (`calendar3.nu`), immediately updating the 006.2 heatmap and 006.4 task list.
-->

## Benchmark

<span class="md-typeset-planned">Provide examples of focus timers and task-linked Pomodoro counters.</span>

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow for switching between clock, Pomodoro, and task-linked focus mode.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the clock, timer, and focus mode states in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe the timer state machine and how task duration logs sync back to `calendar3.nu`.</span>

