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
- Container Geometry (Bento Grid aligned: 330px Calendar/Timer column + 10px gap + 440px Daily Tasks = 780px Habit Tracker width):
  - Outer Frame: 440px wide, #09090b fill, 5px corner radius, 10px padding.
  - Inner Frame: 420px wide, 1px inside stroke rgba(250, 250, 250, 0.05), 25px padding (370px content width), 12px vertical spacing.
- Header Row (370px wide):
  - Left: Title ("Today, Oct 31") + summary subtitle (`"5 tasks  •  2h 15m left"`).
  - Right: `+` IconButton (expands/focuses an inline `Input Text` row to quick-add a task or subtask).
- Three Collapsible Sections:
  1. Passed: Tasks scheduled earlier today whose start/due time has passed without completion (`#e5c07b` warning accent on overdue time badge).
  2. Later Today: Upcoming scheduled tasks for the remainder of the day, including expandable parent tasks with indented subtasks (Super Productivity style).
  3. Completed: Tasks finished today (strikethrough `#fafafa` at 40% opacity, `#4ac26b` checked box, and logged duration).
- Task & Subtask Row Anatomy (Super Productivity style):
  - Checkbox (`14x14` rounded square) + Title (`Inter` Medium 12px) + optional Subtask counter/expand chevron (`▾ 1/3`) + Category tag (`Study`, `Work`) + Time slot & Tracked/Estimate readout (`42m / 1h` or `14:00`) + Play/Pause (`▶`/`⏸`) focus button.
  - Indented Subtask Rows (`20px` left indent with a subtle vertical guide line `1px` `rgba(250, 250, 250, 0.08)`): Each subtask has its own checkbox, title, time estimate (`20m`), and Play/Pause button.
- 3 Views / States in Figma:
  1. Default Day View (Passed, Later Today with expanded subtasks, and Completed sections)
  2. Active Task Focusing (Synced with 006.3 Focus Timer: active task/subtask highlighted with `#121215` fill, `1px` `#60cdea` border, live `42m / 1h` counter in `#60cdea`, and Pause button)
  3. Inline Quick-Add / Edit Task (Header `+` active with an inline `Input Text` `99:115` row for entering a new task or subtask with `@time`, `#category`, and `~estimate` syntax).
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

