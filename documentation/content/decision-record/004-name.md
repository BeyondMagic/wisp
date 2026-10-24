---
icon: lucide/tag
---

<!-- markdownlint-disable MD033 -->

# 004: Project Name

- **Type:** Product
- **Status:** Accepted
- **Date:** 2026-10-23 (Initial: 2026-09-25)
- **Author(s) / Deciders:** João V. Farias
- **Question:** What name and identifier will represent the project across repositories, package registries, and documentation?

## Context

The project is an experimentation as a shell for the desktop, providing a graphical user interface to interact with the operating system, launch applications, manage windows, and customize the desktop environment.

A project name shapes discoverability, CLI/package ergonomics, and brand identity. Functional names are often more discoverable and easier to remember than abstract or metaphorical names:

- [NASA](https://www.nasa.gov): National Aeronautics and Space Administration
- [Vocaloid](https://vocaloid.com): Voice + Android
- [WISP](https://github.com/beyondMagic/wisp): Widget Interface & Shell Platform

## Requirements and Restrictions

- **Pronounceability and Brevity:** The name SHOULD be short, easy to remember, and easy to pronounce.
- **Namespace Availability:** The name SHOULD be unique and conflict-free across target repositories and documentation.

## Alternatives

### Initial Selection (2026-09-25)

- **`lovemii`:** Kept the name of my earlier AGS-based shell because it was already known and carried personal meaning.

### Revision and Functional Name Exploration (2026-10-22)

I explored more functional compound names, object nouns, and backronyms:

- Window + Widget:
  - WinWidge, WidgeWin, WinWidget, WidgetWin, WiWi
- Widget + Desktop:
  - Widtop, DeskWid, WidDesk, DeskWidget, **WiDe**
- Shell + Widget:
  - SheWid, WidShell, Shelget, Wighell
- Window + Shell:
  - WinShell, ShellWin
- Desktop + Shell:
  - DeskShell, ShellTop, Deksh, Shelktop <!-- desktop, but shell -->
- Short / pronounceable coinages:
  - Kaido, Lumo, Vela, Orbis, Nook, Halo (likely taken)
- Meaning-based (window, frame, layer, light):
  - Fenster (window, DE), Casement, Lumen, Panes, Sill
- Object-words (real English nouns we could draw as a logo):
  - **Wicket** <!-- window + widget, literally a small window/door -->
  - Sash <!-- window sash -->
  - Latch, Hinge, Mullion, Transom
  - Bezel <!-- the frame around a screen -->
  - Dock
  - Shelf <!-- shell -> shelf -->
  - Hull <!-- shell -> hull -->
  - Loom
  - Hive <!-- widget grid -->
  - **Pod**, **Nest**, Tile <!-- window tiling -->, Slate, Ledge, **Prism**, Lens, Lantern, Wick
- **WISK:**
  - Widget Interface and Shell Kernel / Window Interface and Shell Kernel (reads as "whisky")
- Similar-sounding acronyms (easy to pronounce, stand for something, and carry meaning by sound):
  - **WHISK:** Window Handling Interface Shell Kit / Widget Host Interface Shell Kit
  - **WISP:** Widget Interface Shell Platform / Window Interface Shell Provider
  - **GIN:** Graphical Interface Nucleus / GUI Interface Node
  - **RUM:** Reactive UI Manager / Rendering User Modules
  - **ALE:** Application Layer Environment / Aesthetic Layout Engine
  - **MEAD:** Modular Environment And Desktop / Modular Element and Application Dock
  - **BREW:** Base Runtime Environment for Widgets / Blended Rendering Environment for Windows
  - **MALT:** Modular Application Layer Toolkit
  - **CASK:** Composable Application Shell Kit / Container And Shell Kit
  - **STOUT:** Shell Toolkit Of Unified Tiles
  - **LAGER:** Layout And Grid Engine Runtime
  - **PILS:** Panel Interface Layout System
  - **PORT:** Panels, Ordering and Rendering Toolkit
  - **PINT:** Panels, Icons, Notifications and Themes
  - **TONIC:** Toolkit Of Native Interface Components
  - **SODA:** Shell Of Desktop Applications
  - **CIDER:** Composable Interface Desktop Environment Runtime
  - **SAKE:** Shell And Kernel Environment
  - **FLASK:** Floating Layer Application Shell Kit
- Non-drink acronyms:
  - **LARK:** Layout And Rendering Kit
  - **WREN:** Widget Rendering ENgine / Window Rendering ENgine
  - **FERN:** Floating Environment Rendering Node

## Decision

~~The decision is to keep the name `lovemii` for this new shell, as it is already known and used, and it has a good meaning behind it.~~

I have revised and chosen `WISP`, standing for **Widget Interface & Shell Platform**, as the new name for the project. It is short, easy to remember, and easy to pronounce, while referring to a thin thread of smoke associated with lightness and elegance.

## Consequences

### Positives

- Short, pronounceable acronym that directly states what the platform is (Widget Interface & Shell Platform).
- Carries a clear visual metaphor (a thin thread of smoke) for branding and iconography.

### Negatives

- Transitioning from `lovemii` to `WISP` requires updating repository references and branding assets where the old name was used.
- Common English noun (`wisp`) shares search results with unrelated tools outside the Wayland desktop domain.
