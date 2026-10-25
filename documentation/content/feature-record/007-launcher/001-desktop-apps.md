---
icon: lucide/app-window
---

<!-- markdownlint-disable MD033 -->

# 007.1: Desktop Applications

- **Status:** **Accepted**
- **Date:** 2026-10-24
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

The desktop applications provider powers the root search view of the launcher. It indexes installed system and user desktop entries, filters them via fuzzy query matching, and exposes fast keyboard shortcuts (`Alt + 1..8`) to launch target applications immediately.

## Benchmark

### Legacy `lovemii` Astal Launcher

The legacy configuration in `widget/launcher/index.tsx` established the core interaction model:

- Application querying via `AstalApps.Apps()` restricted results to the top 8 matches (`fuzzy_query(text).slice(0, 8)`).
- Visual shortcut badges (`∷1` through `∷8`) aligned to the right side of each result item.
- Keybinding handler in `onKey` intercepting `Alt + 1..8` to execute the corresponding indexed result without navigating the arrow keys.
- Direct keystroke capture: typing any alphanumeric key or backspace while the launcher overlay was open directed input straight into the search entry.

## Interaction Flow

```mermaid
flowchart TD
    Open[User triggers Meta + D] --> ResetState[Clear query, focus input, populate recent/top apps]
    Type[User types query] --> FilterApps[Fuzzy filter Quickshell.DesktopEntries]
    FilterApps --> Slice[Slice top 8 results]
    Slice --> Display[Render 8 application rows with shortcut badges: ∷1 to ∷8]

    KeySelect[User presses Alt + 1..8] --> LaunchIndexed[Launch app at index]
    EnterSelect[User presses Enter] --> LaunchFirst[Launch top app at index 0]
    ClickSelect[User clicks row] --> LaunchClicked[Launch clicked app]

    LaunchIndexed --> Close[Close launcher overlay]
    LaunchFirst --> Close
    LaunchClicked --> Close
```

1. **Search & Indexing:**
   - On opening the launcher, the search input gains focus with an empty query.
   - As the user types, the provider fuzzy matches the query against application names, executable names, generic names, and keywords.
   - The result set is capped at 8 items to prevent list clutter and maintain visual consistency with number key shortcuts.

2. **Keyboard Navigation & Execution:**
   - Pressing `Enter` executes the top result (index 0) immediately.
   - Pressing `Alt + 1` through `Alt + 8` executes the matching application row directly.
   - Arrow keys (`Up` / `Down`) or `Tab` / `Shift + Tab` cycle selection through the list.
   - Clicking an application row executes it.
   - Any launch action closes the launcher overlay.

## Visual Design

```mermaid
graph TD
    subgraph Palette["Command Palette Window"]
        direction TB
        Input["Search Entry: 'Start typing to search'"]
        Separator["Divider"]
        subgraph Rows["Top 8 Results"]
            direction TB
            Row1["App Icon 1 | Application Name 1 | ∷1"]
            Row2["App Icon 2 | Application Name 2 | ∷2"]
            Row3["App Icon 3 | Application Name 3 | ∷3"]
            Row4["App Icon 4 | Application Name 4 | ∷4"]
            Row5["App Icon 5 | Application Name 5 | ∷5"]
            Row6["App Icon 6 | Application Name 6 | ∷6"]
            Row7["App Icon 7 | Application Name 7 | ∷7"]
            Row8["App Icon 8 | Application Name 8 | ∷8"]
            Row1 ~~~ Row2 ~~~ Row3 ~~~ Row4 ~~~ Row5 ~~~ Row6 ~~~ Row7 ~~~ Row8
        end
        Input --> Separator
        Separator --> Row1
    end
```

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
