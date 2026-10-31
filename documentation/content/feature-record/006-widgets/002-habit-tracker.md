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
- Container Geometry:
  - Outer Frame: 780px wide, #09090b fill, 5px corner radius, 10px padding.
  - Inner Frame: 760px wide, 1px inside stroke rgba(250, 250, 250, 0.05), 25px padding (710px content width), 12px vertical spacing.
- Header Row (710px wide):
  - Left: Title ("Activity" / "Habits & Tasks") and quick toggle button for Today's Habit Check-in drawer.
  - Right: Year stepper (`< 2026 >`, matching 006.1 Calendar) + WISP Dropdown control (`All tasks & habits`, `Study`, `Work`, `Exercise`, `Reading`).
- Heatmap Grid (710px wide):
  - Left Weekday Axis: 24px wide (`Mon`, `Wed`, `Fri` aligned to rows 2, 4, 6 in `Inter` Regular 10px, rgba(250, 250, 250, 0.40)).
  - 53-Week Matrix: 686px wide (`53` columns x `10px` + `52` gaps x `3px`), 7 rows (`7` x `10px` + `6` gaps x `3px` = `88px` tall), `2px` cell corner radius, with `Jan`..`Dec` month labels along the top.
- 5-Tier Green Intensity Scale (derived from `status/success` #4ac26b):
  - Level 0 (0 completed): #121215
  - Level 1 (1-2 completed): rgba(74, 194, 107, 0.25)
  - Level 2 (3-4 completed): rgba(74, 194, 107, 0.50)
  - Level 3 (5-6 completed): rgba(74, 194, 107, 0.75)
  - Level 4 (7+ completed): #4ac26b (100%)
- Footer Row & Inline Day Inspection:
  - Default: Left side shows yearly total and active streak (`842 completed in 2026  •  14d streak`); right side shows `Less [0][1][2][3][4] More` legend.
  - Day Hover / Selection: Highlights the hovered 10x10 cell with a 1px #60cdea border and replaces the left footer text inline with that day's breakdown (`Oct 31, 2026: 6 completed  •  2h 15m focused`) instead of spawning a floating tooltip.
- 4 Views / States in Figma:
  1. Default Year Heatmap (All tasks & habits)
  2. Category Filter Open (Dropdown open filtering to a single habit/category)
  3. Day Inspection (Hovered/Selected day showing inline breakdown in footer)
  4. Today's Quick Habit Check-in (Expanded bottom strip of today's recurring habits that can be checked off directly to update today's cell and sync with `calendar3.nu`).
-->

## Benchmark

<span class="md-typeset-planned">Provide examples of contribution heatmaps and habit grids (such as GitHub Contributions).</span>

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow for filtering habit categories and inspecting daily completion counts on hover.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the habit and task heatmap widget in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe how historical completion data is aggregated from `calendar3.nu` and mapped to color intensity tiers.</span>

