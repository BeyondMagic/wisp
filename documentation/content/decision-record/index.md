---
icon: lucide/milestone
---

# Decision Record

Technical, architectural, product, and design decisions, along with the reasoning behind them, are documented here.

## Recorded Decisions

| ID  | Date       | Decision                                           | Type         | Status       |
| :-- | :--------- | :------------------------------------------------- | :----------- | :----------- |
| 000 | 2026-10-03 | [Template](./000-template.md)                      | -            | **Accepted** |
| 001 | 2026-10-24 | [Project Idea and Scope](./001-idea.md)            | Product      | **Accepted** |
| 002 | 2026-10-03 | [License Selection](./002-license.md)              | Strategy     | **Accepted** |
| 003 | 2026-10-24 | [Writing Style](./003-writing-style.md)            | Social       | **Accepted** |
| 004 | 2026-10-23 | [Project Name](./004-name.md)                      | Product      | **Accepted** |
| 005 | 2026-10-18 | [Quality Factors](./005-quality-factors.md)        | Architecture | Proposed     |
| 006 | 2026-10-03 | [Requirements](./006-requirements.md)              | Product      | **Accepted** |
| 007 | 2026-10-28 | [Architecture](./007-architecture.md)              | Architecture | **Accepted** |
| 008 | 2026-10-18 | [AI Usage Policy](./008-ai-usage.md)               | Social       | Proposed     |
| 009 | 2026-09-26 | [Visual Identity and UI](./009-visual-identity.md) | Design       | **Accepted** |
| 010 | 2026-10-10 | [UX Paradigm and Flows](./010-ux-paradigm.md)      | Design       | Proposed     |
| 011 | -          | [Testing Strategy](./011-testing-strategy.md)      | Operational  | Planned      |
| 012 | -          | [CI/CD and Tooling](./012-ci-cd-and-tooling.md)    | Operational  | Planned      |

<!--
For LLMs, agents, and contributors: not every Recorded Decision is needed for every project. For example, CLI libraries do not need UI design records; mark inapplicable records as Rejected after confirming with the user.
-->

## Legend

### Status

- **Planned**: template of a decision record before project-specific changes;
- **Proposed**: the decision is under discussion or drafted as a template default and has not been finalized yet;
- **Accepted**: the decision has been made and is being implemented;
- **Rejected**: the decision was considered or found inapplicable and was not chosen;
- **Deprecated**: the decision was once accepted but is no longer in use or recommended.

### Type

- **Architecture**: decisions covering databases, file and folder organization, code structure, diagrams, or system boundaries;
- **Social**: decisions covering communication style, human and AI interaction rules, team agreements, or contribution standards;
- **Design**: decisions covering user interface style, user experience flows, interaction paradigms, or design tooling;
- **Product**: decisions covering project purpose, naming, scope, target audience, feature prioritization, or roadmap;
- **Security**: decisions covering compliance, risk acceptance criteria, data retention policies, or security trade-offs;
- **Operational**: decisions covering deployment pipelines, hosting strategies, monitoring, or operational tooling;
- **Strategy**: decisions covering licensing, business models, competitive positioning, or vendor selection.
