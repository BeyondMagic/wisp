---
icon: lucide/check-square
---

<!-- markdownlint-disable MD033 -->

# 006.4: Daily Tasks

- **Status:** <span class="md-typeset-planned">Proposed</span>
- **Date:** 2026-10-31
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

A day-focused task list widget inspired by [Super Productivity](https://super-productivity.com/). It organizes the current day's schedule into three collapsible sections: tasks that have **Passed**, tasks scheduled for **Later Today**, and **Completed** tasks.

<!--
Specifications:
- Sections:
  1. Passed: Tasks scheduled earlier today whose start/due time has passed without completion.
  2. Later Today: Upcoming tasks scheduled for the remainder of the current day.
  3. Completed: Tasks finished today (with strikethrough/muted styling and logged duration).
- Actions per Task Row:
  - Start / Focus button: Activates 006.3 (Focus Timer) bound to this task and begins counting elapsed time.
  - Checkbox / Complete toggle: Marks the task as done, moves it to Completed, and increments today's cell in 006.2 (Habit & Task Tracker).
- Backend: Reads and updates events/tasks via the local state cache synced with `calendar3.nu` (Google Calendar).
-->

## Benchmark

<span class="md-typeset-planned">Provide examples of daily task views in Super Productivity.</span>

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow for starting a task timer, checking off tasks, and transitioning items across Passed, Later Today, and Completed sections.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the daily tasks widget in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe the task grouping logic by timestamp and synchronization with `calendar3.nu`.</span>

