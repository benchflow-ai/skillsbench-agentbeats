# Prebuilt Task Environment Images

These maps bind SkillsBench public task ids to optional digest-pinned task
environment cache images for AgentBeats public self-runs.

The worker consumes this as `SKILLSBENCH_WORKER_PREBUILT_IMAGES`. A cache ref is
used only when it resolves; otherwise the runtime-first worker falls back to the
baked local `tasks/<id>/environment/Dockerfile`.

Each value must be a public `linux/amd64` image reference pinned with
`@sha256:<digest>`. Keep `tasks_excluded/` out of these maps unless a separate
non-public/debug scenario explicitly enables excluded tasks.

For `standard-v1`, this file is not deploy proof and is not required to cover
every public task. It is an acceleration hint for tasks whose cache images are
already public and verified.

For full adoption, use the shared package:

```text
ghcr.io/benchflow-ai/skillsbench-task-env
```

Use tags such as `standard-v1-citation-check` for cache publication, then pin
the cache map by digest.
