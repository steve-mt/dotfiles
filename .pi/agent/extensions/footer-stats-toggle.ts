/**
 * Footer Stats Toggle - /stats to hide/show the footer stats line
 *
 * Custom footer that always shows:
 *   - pwd (git branch) • session name
 *   - model • thinking level
 *
 * /stats toggles the token/cost/context stats line (↑17k ↓1.1k R74k ...).
 * MCP and Cursor SDK extension statuses are always hidden; other extension statuses show.
 *
 * Preference persists across restarts in ~/.pi/agent/footer-stats.json.
 */

import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

const PREFS_FILE = path.join(os.homedir(), ".pi", "agent", "footer-stats.json");

function loadHidden(): boolean {
	try {
		return JSON.parse(fs.readFileSync(PREFS_FILE, "utf8")).hidden === true;
	} catch {
		return false;
	}
}

function saveHidden(hidden: boolean): void {
	try {
		fs.writeFileSync(PREFS_FILE, JSON.stringify({ hidden }), "utf8");
	} catch {
		// Non-fatal: preference just won't persist
	}
}

function formatCwd(cwd: string): string {
	const home = os.homedir();
	return home && cwd.startsWith(home) ? `~${cwd.slice(home.length)}` : cwd;
}

function sanitize(text: string): string {
	return text.replace(/[\r\n\t]/g, " ").replace(/ +/g, " ").trim();
}

/** Compact token count formatting, same as the default footer. */
function formatTokens(count: number): string {
	if (count < 1000) return count.toString();
	if (count < 10000) return `${(count / 1000).toFixed(1)}k`;
	if (count < 1000000) return `${Math.round(count / 1000)}k`;
	if (count < 10000000) return `${(count / 1000000).toFixed(1)}M`;
	return `${Math.round(count / 1000000)}M`;
}

interface UsageTotals {
	input: number;
	output: number;
	cacheRead: number;
	cacheWrite: number;
	cost: number;
}

/** Accumulate usage across all session entries, same as the default footer. */
function computeUsage(ctx: ExtensionContext): { totals: UsageTotals; cacheHitRate?: number } {
	const totals: UsageTotals = { input: 0, output: 0, cacheRead: 0, cacheWrite: 0, cost: 0 };
	let cacheHitRate: number | undefined;

	const add = (usage: { input: number; output: number; cacheRead: number; cacheWrite: number; cost: { total: number } }) => {
		totals.input += usage.input;
		totals.output += usage.output;
		totals.cacheRead += usage.cacheRead;
		totals.cacheWrite += usage.cacheWrite;
		totals.cost += usage.cost.total;
	};

	for (const entry of ctx.sessionManager.getEntries()) {
		if (entry.type === "message" && entry.message.role === "assistant") {
			const usage = entry.message.usage;
			add(usage);
			const promptTokens = usage.input + usage.cacheRead + usage.cacheWrite;
			cacheHitRate = promptTokens > 0 ? (usage.cacheRead / promptTokens) * 100 : undefined;
		} else if (entry.type === "message" && entry.message.role === "toolResult" && entry.message.usage) {
			add(entry.message.usage);
		} else if ((entry.type === "branch_summary" || entry.type === "compaction") && entry.usage) {
			add(entry.usage);
		}
	}
	return { totals, cacheHitRate };
}

export default function (pi: ExtensionAPI) {
	let hidden = loadHidden();

	const customFooter = (ctx: ExtensionContext) => {
		ctx.ui.setFooter((tui, theme, footerData) => {
			const unsub = footerData.onBranchChange(() => tui.requestRender());
			return {
				dispose: unsub,
				invalidate() {},
				render(width: number): string[] {
					const lines: string[] = [];

					// Right side of line 1: model • thinking level — always shown
					const model = ctx.model;
					const modelName = model?.id || "no-model";
					let rightNoProvider = modelName;
					if (model?.reasoning) {
						const level = ctx.thinkingLevel || "off";
						rightNoProvider = level === "off" ? `${modelName} • thinking off` : `${modelName} • ${level}`;
					}
					if (footerData.getAvailableProviderCount() > 1 && model) {
						rightNoProvider = `(${model.provider}) ${rightNoProvider}`;
					}

					// Line 1: pwd (git branch) • session name on the left, model • thinking right-aligned
					let pwd = formatCwd(ctx.sessionManager.getCwd());
					const branch = footerData.getGitBranch();
					if (branch) pwd = `${pwd} (${branch})`;
					const sessionName = ctx.sessionManager.getSessionName();
					if (sessionName) pwd = `${pwd} • ${sessionName}`;

					const minPadding = 2;
					const rightWidth = visibleWidth(rightNoProvider);
					if (rightWidth + minPadding < width) {
						// Truncate pwd to make room, then right-align the model/thinking segment
						const pwdWidth = width - rightWidth - minPadding;
						const pwdTruncated = truncateToWidth(pwd, pwdWidth, "...");
						const padding = " ".repeat(width - visibleWidth(pwdTruncated) - rightWidth);
						lines.push(theme.fg("dim", pwdTruncated + padding + rightNoProvider));
					} else {
						// Too narrow for both — show pwd only
						lines.push(truncateToWidth(theme.fg("dim", pwd), width, theme.fg("dim", "...")));
					}

					// Left side: full stats, only when toggled on
					let statsLeft = "";
					if (!hidden) {
						const { totals, cacheHitRate } = computeUsage(ctx);
						const parts: string[] = [];
						if (totals.input) parts.push(`↑${formatTokens(totals.input)}`);
						if (totals.output) parts.push(`↓${formatTokens(totals.output)}`);
						if (totals.cacheRead) parts.push(`R${formatTokens(totals.cacheRead)}`);
						if (totals.cacheWrite) parts.push(`W${formatTokens(totals.cacheWrite)}`);
						if ((totals.cacheRead > 0 || totals.cacheWrite > 0) && cacheHitRate !== undefined) {
							parts.push(`CH${cacheHitRate.toFixed(1)}%`);
						}
						if (totals.cost) parts.push(`$${totals.cost.toFixed(3)}`);

						const contextUsage = ctx.getContextUsage();
						const contextWindow = contextUsage?.contextWindow ?? model?.contextWindow ?? 0;
						const percentValue = contextUsage?.percent ?? 0;
						const percentDisplay =
							contextUsage?.percent != null
								? `${percentValue.toFixed(1)}%/${formatTokens(contextWindow)}`
								: `?/${formatTokens(contextWindow)}`;
						const colored =
							percentValue > 90
								? theme.fg("error", percentDisplay)
								: percentValue > 70
									? theme.fg("warning", percentDisplay)
									: percentDisplay;
						parts.push(colored);

						statsLeft = parts.join(" ");
						if (visibleWidth(statsLeft) > width) {
							statsLeft = truncateToWidth(statsLeft, width, "...");
						}
					}

					// Line 2: stats (only when toggled on)
					if (statsLeft) {
						// Dim only the plain stats so colored context % keeps its color
						lines.push(theme.fg("dim", statsLeft));
					}

					// Line 3: extension statuses, excluding MCP and Cursor SDK — only if any remain
					const statuses = footerData.getExtensionStatuses();
					const visibleStatuses = Array.from(statuses.entries())
						.filter(([key]) => !key.startsWith("mcp") && key !== "cursor")
						.sort(([a], [b]) => a.localeCompare(b))
						.map(([, text]) => sanitize(text));
					if (visibleStatuses.length > 0) {
						lines.push(truncateToWidth(visibleStatuses.join(" "), width, theme.fg("dim", "...")));
					}

					return lines;
				},
			};
		});
	};

	const apply = (ctx: ExtensionContext) => {
		if (!ctx.hasUI) return;
		customFooter(ctx);
	};

	pi.registerCommand("stats", {
		description: "Toggle the footer stats line (tokens, cost, context usage)",
		handler: async (_args, ctx) => {
			hidden = !hidden;
			saveHidden(hidden);
			apply(ctx);
			ctx.ui.notify(hidden ? "Footer stats hidden (/stats to show)" : "Footer stats shown", "info");
		},
	});

	pi.on("session_start", async (_event, ctx) => apply(ctx));
}
