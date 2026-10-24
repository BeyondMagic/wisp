<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="documentation/content/assets/dark/logotype.svg">
    <source media="(prefers-color-scheme: light)" srcset="documentation/content/assets/light/logotype.svg">
    <img alt="lovemii logotype" src="documentation/content/assets/light/logotype.svg" width="360">
  </picture>
</p>

# lovemii

A minimalist desktop shell for Wayland, built with [Quickshell](https://quickshell.org/) and designed to run alongside [Hyprland](https://hypr.land/).

## Overview

`lovemii` is a desktop shell built around pure black surfaces, high-contrast typography, and opacity-based hierarchy.

## Repository Structure

- [`.template.json`](./.template.json): Template version manifest tracking upstream repository and managed scaffolding paths.
- [`CHANGELOG.md`](./CHANGELOG.md): History of template releases and additions following Keep a Changelog.
- [`AGENTS.md`](./AGENTS.md): Instructions, writing rules, glossary conventions, and workflow standards for AI coding agents and contributors.
- [`.agents/skills/`](./.agents/skills/): Agent skills for requirements interviewing (`grill-me`) and clear technical writing (`humanizer`).
- [`documentation/`](./documentation/): Zensical documentation site containing the project [Glossary](./documentation/content/glossary.md), [Decision Records](./documentation/content/decision-record/index.md), [Feature Records](./documentation/content/feature-record/index.md), and [Metrics & Results](./documentation/content/management/metrics.md).
- [`source/`](./source/): Root directory for Quickshell QML modules and shell source code.
- [`tests/`](./tests/): Root directory for automated unit and integration test suites.

## Documentation

Full project documentation, architectural decision records, and feature specifications are available on the documentation site:

- **Site:** [https://beyondmagic.github.io/lovemii/](https://beyondmagic.github.io/lovemii/)
- **Glossary:** [documentation/content/glossary.md](documentation/content/glossary.md)
- **Decision records:** [documentation/content/decision-record/](documentation/content/decision-record/index.md)
- **Feature records:** [documentation/content/feature-record/](documentation/content/feature-record/index.md)
- **Metrics & results:** [documentation/content/management/metrics.md](documentation/content/management/metrics.md)

## Local Preview

To run the documentation server locally:

```sh
cd documentation
zensical serve          # Live preview on http://localhost:8000
zensical build --clean  # Static build (must pass with 0 warnings)
```

To start the shell with Quickshell:

```sh
quickshell -p source
```

## Checking Template Updates

Consumer projects can check whether the template scaffolding is current:

1. Inspect the installed version in [`.template.json`](./.template.json).
2. Compare with upstream releases:
   ```sh
   git ls-remote --tags https://github.com/BeyondMagic/swe-template
   ```
3. Review [`CHANGELOG.md`](./CHANGELOG.md) and apply scaffolding updates according to the protocol in [`AGENTS.md`](./AGENTS.md).

## License

GNU Affero General Public License v3.0 ([AGPL-3.0-or-later](./LICENSE)).
