---
icon: lucide/server
---

<!-- markdownlint-disable MD033 -->

# 007.4: Service Manager

- **Status:** <span class="md-typeset-planned">Planned</span>
- **Date:** <span class="md-typeset-planned">YYYY-MM-DD</span>
- **Author(s):** [João V. Farias](https://github.com/BeyondMagic)

## Context

I use `dinit` for local system services (`~/.config/nushell/scripts/external/dinitctl.nu`) and [Tailscale](https://tailscale.com/) to connect to my home network and access remote server services. Rather than keeping remote services running at all times or manually SSHing into the home server, this sub-view lists local and remote services with their current status (`Started`, `Stopped`, `Starting`, `Failed`) and toggles them with a single action.

## Benchmark

<span class="md-typeset-planned">Provide examples of service control palettes in reference applications.</span>

## Interaction Flow

<span class="md-typeset-planned">Describe the interaction flow for listing service status, filtering services, and starting/stopping local `dinit` or remote Tailscale services.</span>

## Visual Design

<span class="md-typeset-planned">Provide visual design mockups or wireframes of the service manager sub-view in Figma.</span>

## Implementation

<span class="md-typeset-planned">Describe how `dinitctl.nu list` (`{service, pid, active, target, status}`) and remote Tailscale SSH commands are queried and executed.</span>

