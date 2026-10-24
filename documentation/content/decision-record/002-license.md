---
icon: lucide/scale
---

<!-- markdownlint-disable MD033 -->

# 002: License Selection

- **Type:** Strategy
- **Status:** Accepted
- **Date:** 2026-10-03
- **Author(s) / Deciders:** João V. Farias
- **Question:** Under what license terms will this project's source code, documentation, and assets be distributed?

## Context

Choosing a software license determines how others can run, modify, fork, and distribute the project. Because this shell is an open-source project intended for the Wayland desktop community, I needed to decide between permissive licensing (such as MIT or Apache-2.0) and strong copyleft licensing (such as GPL-3.0 or AGPL-3.0).

I want the code to be freely accessible, and I want any future forks or modifications to remain open to everyone rather than being packaged into closed-source or proprietary distributions.

## Requirements and Restrictions

- **Commercial & Derivative Use:** The project MUST remain free and open source in perpetuity; any improvements, modifications, or derivative works created by others MUST be shared under the same license terms.
- **Network & Remote Deployment Protection:** Protection MUST extend to modifications even if the software is modified and run over a network or remote desktop setup.
- **Dependency Compatibility:** MUST be compatible with standard Linux and Wayland desktop open-source components (QtQuick, Quickshell, Hyprland).

## Alternatives

- **MIT / BSD-2-Clause (Permissive):** Minimal restrictions and high adoption, but allows proprietary forks without returning improvements to the community.
- **Apache-2.0 (Permissive + Patent Grant):** Permissive use with an explicit patent license, but still permits proprietary relicensing of derivatives.
- **MPL-2.0 (Weak Copyleft):** File-level copyleft allowing combination with proprietary files in larger works.
- **GPL-3.0-or-later / AGPL-3.0-or-later (Strong Copyleft):** Requires derivative works (and network deployments for AGPL) to be distributed under the same license.

## Decision

I have chosen the **GNU Affero General Public License version 3.0** (`AGPL-3.0-or-later`).

All project code, widget definitions, and documentation are published under `AGPL-3.0-or-later`. Anyone who uses or redistributes this project is free to inspect, modify, and run the code, provided that any derivative works or distributed versions release their complete source code under the same terms.

## Consequences

### Positives

- Strong copyleft guarantees that improvements made by contributors or downstream forks return to the community.
- Prevents third parties from turning the shell into proprietary, closed-source software.
- The network clause in AGPL closes the software-as-a-service loophole, ensuring transparency if shell components are deployed in remote desktop environments.
- Aligns with the free software philosophy common across the Linux and Wayland desktop ecosystem.

### Negatives

- Strong copyleft can discourage people or organizations that strictly prefer permissive licenses like MIT.
- Cannot be combined into closed-source proprietary software packages.
- Changing the license later requires consent from all copyright holders.
