---
icon: lucide/gauge
---

<!-- markdownlint-disable MD033 -->

# 005: Quality Factors

- **Type:** Architecture
- **Status:** Proposed
- **Date:** 2026-10-18
- **Author(s) / Deciders:** João V. Farias
- **Question:** Which software quality attributes take priority when making architectural and implementation trade-offs?

## Context

Software architectures cannot maximize every quality attribute at once; for example, maximizing runtime resource efficiency often trades off against generality and extensibility. Defining a ranked subset of quality factors upfront gives contributors objective criteria for evaluating design alternatives.

## Reference Catalog of Quality Factors

- **Effectiveness:** Production plan compliance, schedule compliance, and low failure rate.
- **Evolvability / Extensibility / Modifiability:** Modularity, generality, simplicity, and self-descriptiveness when adding or changing capabilities.
- **Human Engineering & Manageability:** Understandability, human-machine interface clarity, and ease of infrastructure support for development and maintenance modifications.
- **Productivity:** Operability and runtime resource efficiency.
- **Safety:** Resource efficiency, avoidance of hazardous operating conditions, and reliable alarm handling for unsafe states.
- **Satisfaction:** Supportability and user perception of requirements fulfillment and performance.
- **Supportability:** Installability, maintainability, and modifiability.
- **Survivability:** System reliability, application reliability, and computational failure recovery.
- **Understandability:** Self-descriptiveness, hardware failure recovery clarity, simplicity, modularity, and adherence to coding and documentation guidelines.
- **Verifiability:** Coding and documentation guideline consistency, documentation accessibility, traceability, and modularity.

## Requirements and Restrictions

- <span class="md-typeset-planned">Select 3 to 5 primary quality factors from the catalog above that govern architectural trade-offs for this project.</span>
- <span class="md-typeset-planned">Specify measurable thresholds where applicable (such as target latency, memory ceiling, recovery time, or test coverage).</span>

## Alternatives

- <span class="md-typeset-planned">**Unranked Quality Goals:** Treating all quality attributes as equally critical leads to deadlocked design reviews and inconsistent optimization.</span>

## Decision

<span class="md-typeset-planned">Rank the chosen quality factors in priority order (1 = highest priority) and state which attributes are intentionally deprioritized when conflicts arise.</span>

## Consequences

### Positives

- <span class="md-typeset-planned">Architectural and code reviews have explicit tie-breakers when design options conflict.</span>

### Negatives

- <span class="md-typeset-planned">Lower-ranked attributes may incur technical debt that must be monitored as the project matures.</span>
