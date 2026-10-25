---
icon: lucide/quote
---

<!-- markdownlint-disable MD033 -->

# 007.2: Quote Maker

- **Status:** Accepted
- **Date:** 2026-10-24
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

Adding multi-line quotes, authors, sources, and dates to the local JSON quote databases (`~/storage/desktop/quotes/*.json`) via the terminal requires typing verbose Nushell array flags (`quotes add [...] --sources [...] --authors [...] --time (...) --database ...`). The Quote Maker sub-view replaces that manual CLI command with a keyboard-friendly form backed directly by `~/.config/nushell/scripts/quotes.nu`.

## Interaction Flow

1. Open the launcher (`Meta + D`) and select **Quote Maker** (or type `quote` and press `Enter`).
2. Enter the first quotation line in the `1st quotation` input field. Long lines wrap automatically and expand the row height.
3. Press `Enter` inside a quotation, author, or source field (or click its `+` button) to append a `2nd`, `3rd`, etc. row for multi-line quotes or multiple authors/sources.
4. Press `Backspace` on an empty additional row (or click `×`) to remove it.
5. Optionally enter a creation date (`YYYY-MM-DD`) in the date field and select the target database (`General`, `Personal`, `TV`, `Books`, `Music`, or `Story`).
6. Press `Ctrl + Enter` or click **Save** to execute `quotes add` via Nushell. On success, the form resets and displays confirmation feedback. Clicking **Cancel** resets all fields, and pressing `Esc` returns to the launcher root view.

## Visual Design

Designed in Figma (`Desktop` -> `Features` -> node `133:264` / `133:265`):

![Quote Maker Figma Design](./assets/quote-maker.png)

## Implementation

- **Source File:** Implemented in `source/quote-maker.qml`.
- **Databases (`~/storage/desktop/quotes/`):**
  - `general.json` (`General`)
  - `personal.json` (`Personal`)
  - `tv.json` (`TV`)
  - `books.json` (`Books`)
  - `music.json` (`Music`)
  - `story.json` (`Story`)
- **Execution (`Quickshell.Io.Process`):** Serializes non-empty `words`, `authors`, `sources`, optional `time`, and `database` path into `QUOTE_PAYLOAD` and invokes `nu -c "use ~/.config/nushell/scripts/quotes.nu; ..."`. Empty `authors`, `sources`, or `time` fields pass `null` to match the schema of `quotes.nu`.

