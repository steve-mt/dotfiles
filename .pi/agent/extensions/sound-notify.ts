/**
 * Pi Sound Notify Extension
 *
 * Plays a sound when:
 *  - pi finishes responding and is idle, waiting for the next user message
 *  - pi shows any confirmation/selection/input dialog (permission prompts,
 *    MCP tool-approval, project trust, session-switch confirmations, etc.)
 *
 * macOS: uses `afplay` with a system sound (or a custom file via PI_NOTIFY_SOUND).
 */

import type { ExtensionAPI, ExtensionUIContext } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";

const DEFAULT_SOUND = "/System/Library/Sounds/Glass.aiff";
const DEFAULT_PROMPT_SOUND = "/System/Library/Sounds/Ping.aiff";

function playFile(file: string): void {
	if (process.platform === "darwin") {
		execFile("afplay", [file], () => {});
	} else {
		process.stdout.write("\x07");
	}
}

/** Sound for "pi is idle, ready for your next message". */
function playReadySound(): void {
	playFile(process.env.PI_NOTIFY_SOUND || DEFAULT_SOUND);
}

/** Sound for "pi needs a decision from you right now" (dialogs/prompts). */
function playPromptSound(): void {
	playFile(process.env.PI_NOTIFY_PROMPT_SOUND || DEFAULT_PROMPT_SOUND);
}

const PATCH_MARKER = Symbol.for("pi.soundNotify.patched");
type PatchableUI = ExtensionUIContext & { [PATCH_MARKER]?: boolean };

/**
 * Wrap the shared ctx.ui dialog methods so any confirm/select/input prompt
 * also plays a sound. ctx.ui is a shared instance across extensions, so
 * this covers built-in-style prompts raised by other extensions/packages
 * (e.g. pi-mcp-adapter's tool-approval dialog) too, not just this one.
 * Idempotent: only wraps a given ui instance once.
 */
function patchUIDialogs(ui: ExtensionUIContext | undefined): void {
	if (!ui) return;
	const target = ui as PatchableUI;
	if (target[PATCH_MARKER]) return;
	target[PATCH_MARKER] = true;

	const methods = ["select", "confirm", "input", "editor"] as const;
	for (const method of methods) {
		const original = target[method] as (...args: unknown[]) => unknown;
		if (typeof original !== "function") continue;
		target[method] = ((...args: unknown[]) => {
			playPromptSound();
			return original.apply(target, args);
		}) as typeof target[typeof method];
	}
}

export default function (pi: ExtensionAPI) {
	// Patch as early and as often as possible; it's a no-op after the first call.
	pi.on("session_start", async (_event, ctx) => patchUIDialogs(ctx.ui));
	pi.on("before_agent_start", async (_event, ctx) => patchUIDialogs(ctx.ui));

	pi.on("agent_settled", async (_event, ctx) => {
		patchUIDialogs(ctx.ui);
		// Only chime when pi is truly idle and waiting on the user
		// (not mid auto-retry/compaction/queued follow-up).
		if (ctx.isIdle()) {
			playReadySound();
		}
	});
}
