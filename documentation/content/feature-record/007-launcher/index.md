<!-- markdownlint-disable MD033 -->

# 007: Launcher

- **Status:** <span class="md-typeset-planned">Proposed</span>
- **Date:** <span class="md-typeset-planned">YYYY-MM-DD</span>
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

<span class="md-typeset-planned">Provide context for what this feature is about, the motivation behind it, and the goal it aims to achieve.</span>

Beyond launching desktop applications, the launcher acts as the central keyboard-driven command palette for executing script-backed utilities without dedicated standalone windows:

- **Service Management:** Start, stop, and inspect local (`dinit` / `systemd`) or remote home-server services over [Tailscale](https://tailscale.com/) via SSH/script commands with live status checks.
- **Screen OCR:** Trigger screen region capture and optical character recognition (`grim` + `slurp` -> `tesseract` / `RapidOCR` / `PaddleOCR` -> `wl-copy`) with completion feedback sent to [005: Notifications](../005-notifications.md).
- **Quick Utilities:** Mathematical expressions (`qalculate`), dictionary lookup (`dict.nu`), emoji/kaomoji picker, and shell widget toggles.

## Benchmark

<span class="md-typeset-planned">Provide examples of this feature implemented by other developers or in similar applications, with leading features highlighted.</span>

### [PowerToys Command Palette](https://learn.microsoft.com/en-us/windows/powertoys/command-palette/overview)

![alt text](./assets/cmdpal-overview1.gif)

### [PowerToys Run utility](https://learn.microsoft.com/en-us/windows/powertoys/run)

![alt text](./assets/powerrun-demo.gif)

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow of the feature in a use-case format.</span>

1. `Meta key` + `D` triggers the launcher to open.

<!--

enable/disable dinit services (this can be just predefined commands, but with a check before showing which one)
start/stop remote home-server services over Tailscale
run screen OCR (grim -> tesseract/PaddleOCR/RapidOCR -> wl-copy)
manage other widgets (can be predefined commands).
run extensible predefined commands:
    get dictionary from word, like dict.nu
    list emoji, kaomojis
calculate mathematical expressions using Qalculate:
    set up own service (libcalculate running on background with Quickshell and only read commands when sent to it)
run desktop apps.
Make schema.
Change from JSON to TOML with additional script.

-->

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the feature in Figma.</span>

## Implementation

<span class="md-typeset-planned">Provide a detailed description of how the feature will be implemented, including any technical considerations, dependencies, and potential challenges.</span>
