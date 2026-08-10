---
name: thermos
description: "Launch both thermo-nuclear review subagents in parallel, then synthesize their findings. Use for thermos, double thermo review, or combined bug/security and code-quality branch audits."
disable-model-invocation: true
---

# Thermos

Run the two thermo review passes as parallel subagents via the pi-subagents extension, then synthesize their results.

## Workflow

1. Determine the review scope from the user request, PR, current branch, or relevant changed files.
2. Gather the diff and any file/context excerpts needed for reviewers to evaluate the change without guessing (default base `main`: `git diff main...HEAD` output plus full contents of the changed files).
3. Launch both subagents in parallel with a single `subagent` tool call. Background execution is the default in pi-subagents, so no extra flag is needed:

   ```js
   subagent({ workflowScript: `
     const results = await runs.all([
       { key: "audit", agent: "thermo-nuclear-review-subagent", task: "<scoped prompt with ### Git / diff output and ### Changed file contents>" },
       { key: "quality", agent: "thermo-nuclear-code-quality-review-subagent", task: "<same scoped prompt>" }
     ]);
     return results.map(r => r.output);
   ` })
   ```

   - `thermo-nuclear-review-subagent`: bugs, breakages, security, devex regressions, feature-flag leaks, and other branch-audit risks.
   - `thermo-nuclear-code-quality-review-subagent`: maintainability, structure, file-size growth, spaghetti, abstractions, and codebase-health risks.
4. Pass each subagent the same scoped diff/file context and ask it to return prioritized findings with file references and evidence.
5. After both finish, synthesize the results with findings first, deduplicated across reviewers. Weight overlapping findings more heavily, resolve disagreements with your own judgment, and keep summaries brief.

If individual subagent summaries are already visible to the user, do not restate them wholesale. Surface the unified verdict, the highest-signal findings, and any remaining uncertainty.
