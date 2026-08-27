/**
 * Block Git Writes
 *
 * Hard-blocks bash commands that publish changes:
 * - git commit
 * - git push
 * - gh pr create
 *
 * Unconditional (no UI prompt): the model receives the block reason and must
 * leave committing, pushing, and PR creation to the user.
 *
 * Parsing is segment/token-based so `cd repo && git push`, `git -C repo push`,
 * env-var prefixes (`GIT_DIR=x git push`), `xargs git push`, and subshell
 * wrappers (`$(git commit ...)`) are still caught.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// git global flags that consume a separate argument before the subcommand
const GIT_FLAGS_WITH_ARGS = new Set(["-C", "-c", "--git-dir", "--work-tree", "--namespace", "--exec-path"]);

// gh global flags that consume a separate argument before the command group
const GH_FLAGS_WITH_ARGS = new Set(["-R", "--repo"]);

function findBlocked(command: string): string | undefined {
	// Split pipelines/lists so each command in `cd x && git push` is checked
	const segments = command.split(/&&|\|\||[;|]/);

	for (const segment of segments) {
		// Strip subshell/quote wrappers so "$(git commit)" still parses
		const tokens = segment
			.trim()
			.split(/\s+/)
			.map((t) => t.replace(/^[($`]+/, ""));

		const gitIdx = tokens.findIndex((t) => t === "git" || t.endsWith("/git"));
		if (gitIdx !== -1) {
			for (let i = gitIdx + 1; i < tokens.length; i++) {
				const token = tokens[i];
				if (GIT_FLAGS_WITH_ARGS.has(token)) {
					i++; // skip the flag's argument
					continue;
				}
				if (token.startsWith("-")) continue; // other global flags, incl. --flag=value
				if (token === "commit" || token === "push") return `git ${token}`;
				break; // first non-flag token is the subcommand
			}
		}

		const ghIdx = tokens.findIndex((t) => t === "gh" || t.endsWith("/gh"));
		if (ghIdx !== -1) {
			const positional: string[] = [];
			for (let i = ghIdx + 1; i < tokens.length && positional.length < 2; i++) {
				const token = tokens[i];
				if (GH_FLAGS_WITH_ARGS.has(token)) {
					i++; // skip the flag's argument
					continue;
				}
				if (token.startsWith("-")) continue;
				positional.push(token);
			}
			if (positional[0] === "pr" && positional[1] === "create") return "gh pr create";
		}
	}

	return undefined;
}

export default function (pi: ExtensionAPI) {
	pi.on("tool_call", (event) => {
		if (event.toolName !== "bash") return undefined;

		const command = (event.input as { command: string }).command;
		const blocked = findBlocked(command);
		if (blocked) {
			return {
				block: true,
				reason: `Blocked by user policy: '${blocked}' is not allowed. Do not commit, push, or create PRs — leave that to the user.`,
			};
		}
		return undefined;
	});
}
