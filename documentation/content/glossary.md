---
icon: lucide/book-a
---

<!-- markdownlint-disable MD033 -->

# Glossary

<span class="md-typeset-planned">Centralized definitions for domain, architectural, and project terminology. Terms defined at level-3 headings (`### Term`) are automatically linked and shown as tooltips on first mention across the documentation via `zensical-glossary`.</span>

## Documentation and Governance

### Decision Record
<!-- zensical-glossary-aliases: ADR, ADRs, Architectural Decision Record, Decision Records -->

A document capturing an architectural, product, design, operational, security, social, or strategic decision, including context, constraints, considered alternatives, chosen approach, and consequences.

### Feature Record
<!-- zensical-glossary-aliases: Feature Records, Feature Specification, Feature Specifications -->

A specification document defining the context, benchmarks, user interaction flows, visual design, and implementation details for a user-facing or system feature.

### RFC 2119
<!-- zensical-glossary-aliases: RFC-2119, RFC2119 -->

A specification standard defining requirement levels for capitalized keywords: MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL.

### Conventional Commits
<!-- zensical-glossary-aliases: Conventional Commit, conventional commit, conventional commits -->

A structured commit message convention (type(scope): description) providing explicit, machine-readable version history and automated changelog generation.

### Semantic Versioning
<!-- zensical-glossary-aliases: SemVer, Semantic Version, semantic versioning -->

A software release versioning convention structured as MAJOR.MINOR.PATCH, distinguishing breaking API changes, backward-compatible features, and bug fixes.

### Practical Software Measurement
<!-- zensical-glossary-aliases: PSM -->

An objective, information-driven measurement process designed to provide software project managers and engineers with actionable quantitative insights.

### ISO/IEC 15939
<!-- zensical-glossary-aliases: ISO 15939, ISO/IEC 15939:2017 -->

An international standard defining software and systems engineering measurement processes, establishing a common measurement information model from information needs to indicators.

## Architecture and Modeling

### Data-Flow Diagram
<!-- zensical-glossary-aliases: DFD, DFDs, Data Flow Diagram, Data-Flow Diagrams -->

A visual model tracing how data moves through a system, mapping input ingestion, functional transformations, data stores, and emitted outputs across boundaries.

### Use-Case Diagram
<!-- zensical-glossary-aliases: Use-Case Diagrams, use-case diagram, use-case diagrams, Use Case, Use Cases -->

A visual model depicting interactions between external actors (users, external services) and the discrete actions or services provided by the system.

### Functional Requirement
<!-- zensical-glossary-aliases: FR, Functional Requirements, functional requirement, functional requirements -->

A specification of a behavior, service, calculation, data manipulation, or specific business operation that the software system must perform.

### Non-Functional Requirement
<!-- zensical-glossary-aliases: NFR, Non-Functional Requirements, non-functional requirement, non-functional requirements -->

A specification of system-wide quality constraints, including performance, security, reliability, availability, portability, and maintainability thresholds.

### Quality Factor
<!-- zensical-glossary-aliases: Quality Factors, quality factor, quality factors, Quality Attribute, Quality Attributes -->

An observable, measurable software quality attribute (such as modularity, survivability, operability, or verifiability) used to evaluate design trade-offs.

### Class Diagram
<!-- zensical-glossary-aliases: Class Diagrams, class diagram, class diagrams -->

A static structure diagram describing the classes, interfaces, attributes, methods, and relationships constituting an object-oriented system.

### Object Diagram
<!-- zensical-glossary-aliases: Object Diagrams, object diagram, object diagrams -->

A structural diagram depicting a complete or partial snapshot of instantiated objects and their runtime relationships at a specific point in execution.

## Software Licensing and Distribution

### Permissive License
<!-- zensical-glossary-aliases: permissive license, permissive licenses, Permissive Licenses -->

An open-source license (such as MIT or Apache-2.0) that permits unrestricted commercial use, modification, and proprietary distribution, requiring only attribution.

### Copyleft
<!-- zensical-glossary-aliases: copyleft, Copyleft License, copyleft license, copyleft licenses -->

A licensing rule (such as GPL or MPL) requiring derivative works or modifications to be distributed under equivalent license terms to preserve open access.

### SPDX
<!-- zensical-glossary-aliases: SPDX Identifier, SPDX License Identifier, Software Package Data Exchange -->

A standard format and curated registry of short identifiers (such as MIT, Apache-2.0, or GPL-3.0-only) used to express software licenses unambiguously.

## AI and Collaboration Guidelines

### Generative AI
<!-- zensical-glossary-aliases: GenAI, generative AI, AI tools -->

Algorithms, large language models, and automated tools used to generate source code, documentation, test suites, or design artifacts under human supervision.

### Meat-Proxy
<!-- zensical-glossary-aliases: meat-proxy, meat proxy, meat-proxies -->

An anti-pattern where a human blindly copy-pastes AI outputs or questions back and forth without understanding, reviewing, or taking responsibility for the content.

## Design and User Experience

### Intuitive
<!-- zensical-glossary-aliases: intuitiveness, intuitive interface, intuitive design -->

A heuristic judgment of system usability based on transferred domain knowledge. It describes a user's cognitive state when interface patterns and affordances match their prior mental models, minimizing learning energy.

### Design System
<!-- zensical-glossary-aliases: design system, design systems, UI design system -->

A coordinated set of visual assets, reusable UI components, and design tokens that standardize user interface styling and construction across platforms.

### Wordmark
<!-- zensical-glossary-aliases: wordmark, wordmarks, logotype, logotypes -->

A typographic rendering of a project or brand name, designed with specific font weights, kerning, and styling without standalone symbols.

### Interaction Paradigm
<!-- zensical-glossary-aliases: interaction paradigm, interaction paradigms, UX paradigm, UX paradigms -->

The foundational conceptual model and grammar (such as point-and-click, modal editing, or command palettes) governing how users interact with a system.

### Progressive Disclosure
<!-- zensical-glossary-aliases: progressive disclosure -->

An interaction design pattern sequencing information and actions from simple defaults to advanced controls to reduce initial cognitive load.

## Testing and Quality Assurance

### Test Pyramid
<!-- zensical-glossary-aliases: test pyramid, testing pyramid -->

A testing framework advocating a broad base of fast unit tests, a middle layer of integration tests, and a narrow top of end-to-end tests.

### White-Box Testing
<!-- zensical-glossary-aliases: white-box testing, white box testing, structural testing -->

A verification method where tests are designed with explicit visibility into internal module logic, branch conditions, and private structures.

### Black-Box Testing
<!-- zensical-glossary-aliases: black-box testing, black box testing, behavioral testing -->

A verification method where functionality is evaluated strictly against external interfaces, public APIs, or CLI contracts without internal code visibility.

### Continuous Integration
<!-- zensical-glossary-aliases: CI, continuous integration -->

The software engineering practice of automatically compiling, linting, and testing code whenever commits or pull requests are submitted.

### Static Analysis
<!-- zensical-glossary-aliases: static analysis, static code analysis, linter, linters -->

The automated inspection of source code without execution to identify syntax flaws, potential runtime bugs, security issues, and style violations.

## Domain Terms

### Wayland

A display server protocol and library for Linux systems where the compositor acts as the display server, managing window composition and input events directly.

### Quickshell

A QtQuick and QML-based toolkit for building Wayland desktop shells, panels, overlays, and widgets with native compositor integrations.

### Hyprland

A dynamic tiling Wayland compositor providing IPC sockets, workspace management, and window rules.

### Plymouth

A boot splash animation system that runs early in the Linux boot process using Direct Rendering Manager (DRM) and Kernel Mode Setting (KMS) before the display server starts.

