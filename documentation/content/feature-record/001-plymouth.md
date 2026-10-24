<!-- markdownlint-disable MD033 -->

# 001: Plymouth

- **Status:** Proposed
- **Date:** 2026-10-03
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

Plymouth is a graphical boot animation.

It is meant to provide a visually appealing experience during the boot process, hiding the underlying text output and presenting a smooth transition from the bootloader to the desktop environment.

## Benchmark

- [Linux Distro Logos - macOS Boot Style](https://www.opendesktop.org/p/2106821)

It has the logo of a distro in the center and bar of progress below.

- [Dynamic Miku](https://github.com/Thang1191/MikuPlymouth)

It features a dynamic Miku character (37 variants) that dances in a MP3 player style.

## Interaction Flow

1. Turn on the computer;
2. The bootloader loads the kernel and initial RAM disk;
3. Plymouth starts and displays the boot animation;
4. WISP's logo appears on the middle of the screen;
5. the wordmark "WISP" slides in from the left side of the logo and stops at the right side of the logo, centering the logo and wordmark on the screen;
6. the wordmark "WISP" slides out to the right side of the logo and disappears, leaving only the logo centered on the screen;

... Plymouth ends and shows the login screen.

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the feature in Figma.</span>

## Implementation

- It must take at most 2.5 seconds to complete the animation, from the moment the logo appears to the moment it disappears.
