---
icon: lucide/git-merge
---

<!-- markdownlint-disable MD033 -->

# 012: CI/CD and Tooling

- **Type:** Operational
- **Status:** <span class="md-typeset-planned">Planned</span>
- **Date:** <span class="md-typeset-planned">YYYY-MM-DD</span>
- **Author(s) / Deciders:** <span class="md-typeset-planned">DevOps engineers, maintainers, and build infrastructure leads</span>
- **Question:** What static analysis, formatting rules, continuous integration quality gates, and automated delivery pipelines enforce project standards?

## Context

<span class="md-typeset-planned">Automated quality gates prevent style disputes, syntax errors, and broken builds from reaching the shared codebase. Enforcing linters, code formatters, type checkers, and test execution through continuous integration guarantees that every pull request satisfies baseline technical standards before maintainer review.</span>

## Static Analysis and Code Formatting

### Automated Formatting

- <span class="md-typeset-planned">**Formatter Selection:** An automated code formatter (such as Prettier, Ruff, rustfmt, or clang-format) MUST be configured with repository defaults.</span>
- <span class="md-typeset-planned">**Zero-Tolerance Style Policy:** Code style disputes are resolved by the formatter configuration; manual style comments in pull request reviews are prohibited.</span>

### Static Analysis and Linters

- <span class="md-typeset-planned">**Linter Configuration:** High-performance static analysis tools (such as oxlint, ruff, clippy, or eslint) MUST run in strict mode with zero warnings allowed in production code.</span>
- <span class="md-typeset-planned">**Type Safety:** Static type checkers (such as tsc or mypy) MUST run in strict mode prior to test execution.</span>

## Multi-Stage Quality Gate Pipeline

<span class="md-typeset-planned">Continuous integration pipelines MUST execute the following sequential stages on every pull request:</span>

```mermaid
flowchart LR
    Lint["1. Lint & Static Analysis"] --> Fmt["2. Format Check"]
    Fmt --> TypeCheck["3. Type Check"]
    TypeCheck --> Test["4. Automated Tests"]
    Test --> Build["5. Compile & Package"]
```

1. **Lint and Static Analysis:** Detect syntax errors, unused variables, and dangerous code patterns.
2. **Format Verification:** Confirm all touched files match repository formatting rules without modifications.
3. **Type Checking:** Verify API interfaces and type signatures across module boundaries.
4. **Automated Tests:** Execute the unit and integration test suites defined in [011: Testing Strategy](./011-testing-strategy.md).
5. **Compilation and Build:** Verify that production binaries, packages, or documentation sites build cleanly with zero errors.

## Branch Protection and Merge Gates

- <span class="md-typeset-planned">**Protected Branches:** The `master` / `main` branch MUST require passing CI checks and at least one human review before merging.</span>
- <span class="md-typeset-planned">**Commit Message Validation:** Commits MUST adhere to the [Conventional Commits](../glossary.md#conventional-commits) format to enable automated changelog generation.</span>
- <span class="md-typeset-planned">**Local Parity:** Developers and coding agents SHOULD be able to execute identical quality checks locally via task runners (for example, `.vscode/tasks.json` or package scripts) before pushing commits.</span>

## Alternatives

- <span class="md-typeset-planned">**Manual Code Review Only:** Code review without automated tooling wastes reviewer time on formatting, typos, and lint issues that machines catch instantly.</span>
- <span class="md-typeset-planned">**Post-Merge Broken Window Policy:** Merging without blocking gates allows broken builds to enter the main branch, blocking all downstream developers.</span>

## Decision

<span class="md-typeset-planned">Document the selected linters, formatters, type checkers, and GitHub Actions workflow configuration enforcing pull request validation.</span>

## Consequences

### Positives

- <span class="md-typeset-planned">Automated quality gates catch defects before human review, keeping code quality high.</span>
- <span class="md-typeset-planned">Local tooling parity ensures developers and coding agents can verify changes quickly before pushing.</span>

### Negatives

- <span class="md-typeset-planned">Strict CI gates can slow down urgent hotfixes if pipeline runtimes become excessive.</span>

