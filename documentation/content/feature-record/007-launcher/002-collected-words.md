---
icon: lucide/quote
---

<!-- markdownlint-disable MD033 -->

# 007.2: Collected Words

- **Status:** Accepted
- **Date:** 2026-10-24
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

Adding and editing multi-line quotes, authors, sources, and dates in the local JSON quote databases (`~/storage/desktop/quotes/*.json`) via the terminal requires typing verbose Nushell array flags (`quotes add [...] --sources [...] --authors [...] --time (...) --database ...`). The **Collected Words** sub-view replaces manual CLI entry with keyboard-friendly **Save a quote** and **Edit quote** views backed by `~/.config/nushell/scripts/quotes.nu`.

## Interaction Flow

### Save a Quote (`133:264`)

1. Open the launcher (`Meta + D`) and select **Collected Words** (or type `quote` / `words` and press `Enter`).
2. Enter the first quotation line in the `1st quotation` input field. Long lines wrap automatically and expand the row height.
3. Press `Enter` inside a quotation, author, or source field (or click its `+` button) to append a `2nd`, `3rd`, etc. row for multi-line quotes or multiple authors/sources.
4. Press `Backspace` on an empty additional row (or click `×`) to remove it.
5. Optionally enter a creation date (`Date (YYYY-MM-DD, optional)`) and select the target database (`General`, `Personal`, `TV`, `Books`, `Music`, or `Story`).
6. Press `Ctrl + Enter` or click **Save** to execute `quotes add` via Nushell. On success, the form resets and displays confirmation feedback. Clicking **Cancel** resets all fields, and pressing `Esc` returns to the launcher root view.

### Edit a Quote (`142:72`)

1. Select an existing quote from the **Collected Words** list to open the **Edit some quote** form pre-populated with its quotation lines, authors, sources, date, and database.
2. Modify any field, append new rows via `+`, or remove rows.
3. Click **Save changes** (`Ctrl + Enter`) to update the entry in its JSON database, or click **Delete quote** to remove it.

## Visual Design

Designed in Figma (`Desktop` -> `Features` -> section `133:263` **Collected Words**, containing frames `133:264` **Save a quote** and `142:72` **Edit quote**):

![Collected Words Figma Design](./assets/collected-words.png)

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
