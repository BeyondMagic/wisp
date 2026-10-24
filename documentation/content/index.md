---
icon: lucide/book-open
---

<!-- markdownlint-disable MD033 -->

# Introduction

`lovemii` is a personal desktop shell for Wayland, built with [Quickshell](https://quickshell.org/) and designed to run alongside [Hyprland](https://hypr.land/).

![lovemii logotype](assets/light/logotype.svg){: .center-image .only-light }
![lovemii logotype](assets/dark/logotype.svg){: .center-image .only-dark }

It replaces an earlier shell of the same name built with [Aylurs GTK Shell (AGS)](https://aylur.github.io/ags/). While the old shell worked for daily use, it grew organically without structured design rules or interaction specifications. This rewrite restarts the project on Quickshell with a cleaner architecture, better performance, and a consistent visual style.

## Documentation Layout

The documentation is divided into four functional areas:

- **[Glossary](./glossary.md):** Canonical definitions for domain, architectural, and governance terminology. Terms defined here automatically generate tooltips and links across all pages through `zensical-glossary`.
- **[Decision Record](./decision-record/index.md):** Architectural, design, product, operational, and social decisions. Each record documents context, technical constraints, considered alternatives, and consequences.
- **[Feature Record](./feature-record/index.md):** Specifications for user-facing and internal features, including interaction flows, benchmarks, and implementation notes.
- **[Metrics & Results](./management/metrics.md):** Quantitative measurement framework following ISO/IEC 15939 and PSM, tracking commit velocity, code churn, and task distribution.

## Workflow

Projects built with this template follow three core practices:

1. **Explicit Decisions First:** Before writing subsystem code, capture architecture choices, dependency selections, and licensing in a [Decision Record](./decision-record/index.md). When requirements change, update the corresponding record rather than letting documentation drift.
2. **Standard Requirements Language:** Specifications use [RFC 2119](./glossary.md#rfc-2119) keywords (MUST, SHOULD, MAY) to distinguish hard technical constraints from preferences.
3. **Verified Changes:** Every documentation change must pass a clean build (`zensical build --clean`) with zero warnings. Code commits follow [Conventional Commits](./glossary.md#conventional-commits) format.

## Local Documentation Preview

Run the Zensical development server to view edits with live reload:

```sh
cd documentation
zensical serve
```

To build static HTML assets into `documentation/site/`:

```sh
cd documentation
zensical build --clean
```

## License

`lovemii` is free software published under the [GNU Affero General Public License v3.0](https://www.gnu.org/licenses/agpl-3.0.html) (`AGPL-3.0-or-later`).
