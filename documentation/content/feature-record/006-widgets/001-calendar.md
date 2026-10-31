---
icon: lucide/calendar
---

<!-- markdownlint-disable MD033 -->

# 006.1: Calendar

- **Status:** <span class="md-typeset-planned">Proposed</span>
- **Date:** 2026-10-31
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

A minimal monthly calendar widget rendered over the wallpaper. Unlike the legacy `lovemii` calendar popover, it omits the side panel listing daily, weekly, and monthly tasks so schedule details remain dedicated to [006.4: Daily Tasks](./004-daily-tasks.md).

<!--
Specifications:
- Outer Frame: 316px wide, #09090b fill, 5px corner radius, 10px padding.
- Inner Frame: 296px wide, 1px inside stroke rgba(250, 250, 250, 0.05), 20px padding (256px content width), 10px vertical spacing.
- Header Navigation: Dual steppers matching legacy lovemii: `< Month >` aligned left and `< Year >` aligned right, separated from the grid by a 1px horizontal divider rgba(250, 250, 250, 0.05).
- Weekday Header Row: 7 homogeneous columns; configurable in QML between single-letter English (`S`, `M`, `T`, `W`, `T`, `F`, `S`) and Japanese kanji (`日`, `月`, `火`, `水`, `木`, `金`, `土`).
- Day Grid (6 rows x 7 columns, 32x32 cells, 4px gap):
  - Current month weekday: #fafafa (100%).
  - Current month weekend (Sun/Sat): rgba(250, 250, 250, 0.60).
  - Outside month (prev/next overflow): rgba(250, 250, 250, 0.25).
  - Today cell: #121215 fill with 1px inside border #60cdea (or #f4f4f5 fill with #09090b text).
  - Event / Birthday indicator: 4x4 rounded dot (#60cdea for events, #e5c07b for birthdays) centered near the bottom of the cell, with hover tooltip listing event titles from the Google Calendar cache.
-->

## Benchmark

<span class="md-typeset-planned">Provide examples of minimal desktop calendar widgets.</span>

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow for navigating months and selecting dates.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the minimal calendar widget in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe the QML month grid computation and date cell states.</span>

