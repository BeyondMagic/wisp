---
icon: lucide/app-window
---

<!-- markdownlint-disable MD033 -->

# 007.1: Desktop Applications

- **Status:** **Accepted**
- **Date:** 2026-10-24
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

Opening frequently used desktop programs through hierarchical menus or scrolling through long result lists wastes time. Users need immediate access to their applications with direct keystroke shortcuts. The desktop applications provider powers the root search view of the launcher by indexing installed application entries, ranking them through fuzzy query matching, and providing number-key shortcuts (`Alt + 1..8`) to launch top results immediately.

<!--
AI Agent Context & Architecture:
- Legacy reference: `lovemii` astal launcher (`widget/launcher/index.tsx`).
- Backed by `Quickshell.DesktopEntries`. Result set is sliced to the top 8 matches (`slice(0, 8)`).
- Key handling intercepts `Qt.AltModifier` + `Qt.Key_1` through `Qt.Key_8` to execute `results[index].launch()`.
-->

## Benchmark

### Legacy `lovemii` Astal Launcher

The legacy configuration established the base interaction pattern:

- Application querying restricted results to the top 8 matches.
- Visual shortcut badges (`∷1` through `∷8`) aligned to the right side of each result item.
- Keybinding handler in `onKey` intercepted `Alt + 1..8` to execute the corresponding indexed result without navigating arrow keys.
- Direct keystroke capture directed alphanumeric input straight into the search entry.

## Interaction Flow

```mermaid
flowchart TD
    Open[User triggers Meta + D] --> ResetState[Clear query, focus input, show default results]
    Type[User types query] --> FilterApps[Fuzzy filter application catalog]
    FilterApps --> Slice[Slice top 8 results]
    Slice --> Display[Render application rows with shortcut badges: ∷1 to ∷8]

    KeySelect[User presses Alt + 1..8] --> LaunchIndexed[Launch app at index]
    EnterSelect[User presses Enter] --> LaunchFirst[Launch top app at index 0]
    ClickSelect[User clicks row] --> LaunchClicked[Launch clicked app]

    LaunchIndexed --> Close[Close launcher overlay]
    LaunchFirst --> Close
    LaunchClicked --> Close
```

1. **Search and Indexing:**
   - On opening the launcher, the search input gains focus with an empty query.
   - As the user types, the provider fuzzy matches the query against application names, executable names, generic names, and keywords.
   - The result list displays up to 8 items to keep the display readable and aligned with number-key shortcuts.

2. **Keyboard Navigation and Execution:**
   - Pressing Enter launches the top result immediately.
   - Pressing `Alt + 1` through `Alt + 8` launches the corresponding application row directly without arrow navigation.
   - Up and Down arrow keys, or Tab and Shift+Tab, cycle selection through the list.
   - Clicking an application row launches it.
   - Any launch action closes the launcher overlay.

## Visual Design

<!-- Figma visual design export placeholder -->
![Desktop Applications Visual Design](./assets/desktop-apps.png)

## Implementation

### Data Schema

```json
{
  "desktop_apps": {
    "max_results": 8,
    "shortcut_prefix": "∷",
    "enable_alt_numeric_shortcuts": true
  }
}
```

### Quickshell Components

- **Application Catalog:** `Quickshell.DesktopEntries` provides the reactive list of installed desktop entries.
- **Fuzzy Filter:** A JavaScript helper scores and ranks entries against the current search string, taking the first 8 items (`slice(0, 8)`).
- **Shortcut Handling:** `Keys.onPressed` on the root container intercepts `Qt.AltModifier` combined with `Qt.Key_1` through `Qt.Key_8` to call `results[index].launch()`.
- **Execution:** Native execution via `desktopEntry.launch()`, delegating process spawning and desktop environment integration directly to Quickshell without intermediary helper scripts.
