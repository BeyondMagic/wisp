---
icon: lucide/quote
---

<!-- markdownlint-disable MD033 -->

# 007.2: Collected Words

- **Status:** **Accepted**
- **Date:** 2026-10-24
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

Adding and editing multi-line quotations across multiple JSON files via terminal commands requires typing lengthy Nushell arrays and flags for authors, sources, dates, and database targets. This command-line friction makes it cumbersome to record memorable sentences while reading or studying. The Collected Words sub-view provides a keyboard-driven form to record and modify multi-line quotes and metadata backed by local JSON databases.

<!--
AI Agent Context & Architecture:
- Backed by `~/.config/nushell/scripts/quotes.nu`.
- JSON databases reside in `~/storage/desktop/quotes/*.json` (general, personal, tv, books, music, story).
- Component structure: `source/modules/collected_words/` (`CollectedWordsView.qml`, `QuoteInputRow.qml`, `CollectedWordsWindow.qml`).
-->

## Interaction Flow

1. **Adding a Quote:**
   - Opening the launcher and selecting Collected Words focuses the first quotation input field.
   - Entering text in the quotation input wraps lines automatically.
   - Pressing Tab or Shift+Tab navigates across the full field sequence: quotations, authors, sources, date, database dropdown, Save button, and Cancel button. Up and Down arrow keys jump directly between input rows.
   - Pressing Enter inside a quotation, author, or source field (or clicking its add button) appends a new input row and focuses it.
   - Pressing Backspace on an empty added row removes that row and returns focus to the preceding field.
   - Pressing `Ctrl + Enter` from any field (or activating the Save button) validates that at least one quotation line exists, saves the quote to the selected JSON database, resets the form, and refocuses the first quotation row.
   - Activating the Cancel button clears all entered fields. Pressing Escape returns navigation to the launcher root search.

2. **Editing an Existing Quote:**
   - Selecting an existing entry from the quote browser opens the editing form prefilled with its quotation lines, authors, sources, date, and assigned database.
   - Modifying fields, adding rows, or removing rows updates the working record.
   - Activating Save Changes (`Ctrl + Enter`) updates the entry in its JSON file. Activating Delete Quote removes the entry.

## Visual Design

<!-- Figma visual design export placeholder -->
![Collected Words Visual Design](./assets/collected-words.png)

## Implementation

- **Source Files:** Implemented in [`source/modules/collected_words/CollectedWordsView.qml`](file:///home/terra/projects/wisp/source/modules/collected_words/CollectedWordsView.qml), [`source/modules/collected_words/QuoteInputRow.qml`](file:///home/terra/projects/wisp/source/modules/collected_words/QuoteInputRow.qml), and [`source/modules/collected_words/CollectedWordsWindow.qml`](file:///home/terra/projects/wisp/source/modules/collected_words/CollectedWordsWindow.qml). Backend execution is managed in [`source/services/QuotesService.qml`](file:///home/terra/projects/wisp/source/services/QuotesService.qml).
- **Databases (`~/storage/desktop/quotes/`):**
  - `general.json` (General)
  - `personal.json` (Personal)
  - `tv.json` (TV)
  - `books.json` (Books)
  - `music.json` (Music)
  - `story.json` (Story)
- **Execution:** Serializes non-empty fields into a JSON payload and invokes `nu -c "use ~/.config/nushell/scripts/quotes.nu; ..."`. Empty authors, sources, or dates pass `null` values to match the database schema.
