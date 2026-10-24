---
icon: lucide/layers
---

<!-- markdownlint-disable MD033 -->

# Feature List

Specifications, interaction flows, and implementation notes for shell features are documented here.

## User flow architecture

The diagram below maps how users move through the shell, from initial boot to desktop interactions, persistent panel widgets, and overlay utilities:

```mermaid
--8<-- "feature-record/user-flow.mmd"
```

## Features

| ID     | Date                    | Feature                             | Status   |
| :----- | :---------------------- | :---------------------------------- | :------- |
| 000    | 2026-10-03 - 2026-10-03 | [Template](000-template.md) | **Accepted** |
| 001    | 2026-10-03 -            | [Plymouth](001-plymouth.md) | Proposed |
| 002    | 2026-10-03 -            | [Login](002-login.md) | Proposed |
| 003    | 2026-10-03 -            | [Power Management](003-power-management.md) | Planned |
| 004    | 2026-10-03 -            | [System Tray](004-system-tray.md) | Planned |
| 005    | 2026-10-03 -            | [Workspace Tray](005-workspace-tray.md) | Planned |
| 006    | 2026-10-03 -            | [Time Tracker](006-time-tracker/index.md) | Proposed |
| 007    | 2026-10-03 -            | [Notifications](007-notifications.md) | Planned |
| 008    | 2026-10-03 -            | [Overview](008-overview.md) | Planned |
| 009    | 2026-10-03 -            | [Launcher](009-launcher/index.md) | Proposed |
| 010    | 2026-10-03 -            | [Habit Tracker](010-habit-tracker.md) | Planned |
| 011    | 2026-10-03 -            | [Task Tracker](011-task-tracker.md) | Planned |
| 012    | 2026-10-03 -            | [OCR](012-ocr.md) | Proposed |
| 013    | 2026-10-11 -            | [Music Manager](013-music-manager/index.md) | Proposed |
| 014    | 2026-10-12 -            | [Service Manager](014-service-manager/index.md) | Proposed |

<!-- Task Tracker will supersede habit tracker -->

## Legend

- **Planned**: template of a feature record before project-specific changes;
- **Proposed**: the feature is under discussion and has not been approved yet;
- **Accepted**: the feature is approved and scheduled or actively being built;
- **Developed**: the feature is built and in active use;
- **Rejected**: the feature was considered but decided against;
- **Deprecated**: the feature was once in use but is no longer supported or recommended.
