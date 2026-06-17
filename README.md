# SkillsBench AgentBeats

Versioned public AgentBeats configuration for SkillsBench.

Root files are the latest stable aliases. At creation, root mirrors `versions/v1.1`.

## Versions

| Version | Path | Notes |
| --- | --- | --- |
| Latest | `/` | Alias for the latest stable SkillsBench AgentBeats config. |
| v1.1 | `versions/v1.1/` | Current 87-task SkillsBench config using the sandbox A2A endpoint fix. |
| v1.0 | `versions/v1.0/` | Preserved public v1.0 AgentBeats config snapshot. |

## Manifest URLs

Use these raw URLs when registering or updating AgentBeats entries:

- Latest green agent: `https://raw.githubusercontent.com/benchflow-ai/skillsbench-agentbeats/main/green-agent.json5`
- v1.1 green agent: `https://raw.githubusercontent.com/benchflow-ai/skillsbench-agentbeats/main/versions/v1.1/green-agent.json5`
- v1.0 green agent: `https://raw.githubusercontent.com/benchflow-ai/skillsbench-agentbeats/main/versions/v1.0/green-agent.json5`

## Scope

This repository intentionally contains AgentBeats manifests, scenarios, task sets, prebuilt image declarations, deploy bundles, and leaderboard SQL queries only.

It intentionally excludes historical `results/`, `submissions/`, and GitHub Actions workflows. Leaderboard publishing workflows remain in `benchflow-ai/skillsbench-leaderboard` for now.

## Source References

- v1.1 SkillsBench source revision: `38eb0f83cf93a566de846957fcc45e720a172f31`
- v1.1 leaderboard config source snapshot: `d16d6e122942bcd3bdb31d7ed3af6b9935ed7c80`
- v1.0 preserved from the previous live AgentBeats manifest snapshot around `98029394069e05958fcbc164ea3f8c1b0d85e723`
