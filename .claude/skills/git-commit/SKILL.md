---
name: git-commit
description: Create consistent git commits
---

## What I do

Create a commit message for the staged changes using the template below

```text
Title

What
---

Why
---

Testing
---
```

- `Title`: Should follow conventional commits
- `What`: An overview of what the commit is doing.
- `Why`: Why we are doing the change, provide context and even links if possible. Remember someone might read this without a lot of context.
- `Testing`: Optional field when there are code changes you can test locally. Always ask before.
- Use present tense, e.g. "Foo does not work", Avoid past tense, e.g. "Foo did not work"
- Use `Assisted-by: AGENT_NAME:MODEL_VERSION` instead of Co-Authorted. For example `Assisted-by: Claude:claude-3-opus`

## When to use me

Use this when you are asked to create a commit message for the staged changes you have locally.
