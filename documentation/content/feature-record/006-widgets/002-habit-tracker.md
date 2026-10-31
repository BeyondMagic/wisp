---
icon: lucide/grid-3x3
---

<!-- markdownlint-disable MD033 -->

# 006.2: Habit & Task Tracker

- **Status:** <span class="md-typeset-planned">Proposed</span>
- **Date:** 2026-10-31
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

A year-at-a-glance consistency tracker modeled after the GitHub contributions graph. It renders a 7-day by 12-month matrix of small rounded squares where brighter green shades represent days with more completed habits and tasks, backed by Google Calendar (`calendar3.nu`) and equipped with a filter to isolate specific habit or task categories.

<!--
Specifications:
- Grid Layout: 7 rows (days of the week) across 12 months (~52-53 columns) of tiny rounded squares.
- Color Intensity: Multi-stop green scale (up to `#4ac26b` `status/success`) mapped to the count or ratio of completed tasks/habits on each day; `0` completed uses a subtle dark cell fill.
- Filter Control: Dropdown or tag filter in the widget header to show all items or filter by specific habit/task categories (e.g., Study, Work, Exercise, Reading).
- Backend: Synced with Google Calendar via `calendar3.nu` and updated live from the shared local task cache when tasks are completed in 006.3 (Focus Timer) or 006.4 (Daily Tasks).
-->

## Benchmark

<span class="md-typeset-planned">Provide examples of contribution heatmaps and habit grids (such as GitHub Contributions).</span>

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow for filtering habit categories and inspecting daily completion counts on hover.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the habit and task heatmap widget in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe how historical completion data is aggregated from `calendar3.nu` and mapped to color intensity tiers.</span>

