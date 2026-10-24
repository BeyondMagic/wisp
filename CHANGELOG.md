# Changelog

All notable changes to this template project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-10-23

### Added

- Template version manifest (`.template.json`) tracking version, upstream URL, and managed scaffolding paths for consumer projects.
- Template update protocol in `AGENTS.md` and `README.md` enabling humans and coding agents to check and synchronize template updates safely.
- Zensical documentation site with live preview and static build pipelines.
- Centralized project glossary (`documentation/content/glossary.md`) with 16 curated engineering terms and aliases powered by `zensical-glossary`.
- Decision Record framework with sequential records (000 through 008) and streamlined 5-field metadata headers.
- Feature Record specification framework with user flow architecture diagrams and standardized template.
- Practical Software Measurement (PSM / ISO/IEC 15939) metrics page with Mermaid snippets under `documentation/snippets/management/`.
- Automated metrics extraction script (`.github/scripts/update_metrics.py`) and GitHub Actions workflow (`.github/workflows/metrics.yml`) updating management snippets on commit.
- Agent guidelines (`AGENTS.md`) integrating requirements engineering (`grill-me`), writing rules (`humanizer`), and Conventional Commits.
- GitHub Actions deployment workflow for documentation publishing to GitHub Pages.
- VS Code task definitions for Zensical preview and clean build execution.

