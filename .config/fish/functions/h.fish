# Save as ~/.config/fish/functions/h.fish
# Herdr counterpart to t.fish (tmux).
# Usage: h myapp    (resolved via zoxide)
#        h .        (current directory)
#        h          (zoxide fuzzy search)
#        h -n       (zoxide fuzzy search, keep previous workspace)
#        h -n myapp (new/focus workspace, keep previous)
#        h -l       (list workspaces)
#        h -k       (close current workspace)

function h
    if not command -q herdr
        echo "herdr not found"
        return 1
    end

    set -l kill_previous yes

    switch "$argv[1]"
        case -l --list
            herdr workspace list
            return $status
        case -k --kill
            if not set -q HERDR_ENV
                echo "not in a herdr session"
                return 1
            end
            if not set -q HERDR_WORKSPACE_ID
                echo "no current herdr workspace"
                return 1
            end
            herdr workspace close "$HERDR_WORKSPACE_ID"
            return $status
        case -n --new
            set kill_previous no
    end

    set -l query
    if test "$kill_previous" = no
        set query $argv[2]
    else
        set query $argv[1]
    end

    # Resolve directory (same as t.fish)
    set -l dir
    if command -q zoxide
        if test -z "$query"
            set dir (zoxide query -i 2>/dev/null)
            or return 1
        else if test "$query" = "."
            set dir (realpath "." 2>/dev/null)
        else
            set dir (zoxide query -- "$query" 2>/dev/null)
            or begin
                echo "zoxide: no match for '$query'"
                return 1
            end
        end
    else
        test -z "$query"; and set query "."
        set dir (realpath "$query" 2>/dev/null)
    end

    if not test -d "$dir"
        echo "not a valid directory: $dir"
        return 1
    end

    set -l name (basename "$dir")
    # Herdr labels are free-form; still avoid awkward control chars
    set name (string replace -a ':' '_' -- "$name")

    set -l previous_workspace
    if set -q HERDR_WORKSPACE_ID
        set previous_workspace $HERDR_WORKSPACE_ID
    end

    # Find existing workspace by label
    set -l existing_id
    if command -q jq
        set existing_id (
            herdr workspace list 2>/dev/null \
                | jq -r --arg name "$name" \
                    '.result.workspaces[]? | select(.label == $name) | .workspace_id' \
                | head -n1
        )
    end

    set -l target_id

    if test -n "$existing_id"
        set target_id $existing_id
        herdr workspace focus "$target_id" >/dev/null
        or return 1
    else
        # Create workspace focused on project dir
        set -l created
        set created (herdr workspace create --cwd "$dir" --label "$name" --focus 2>/dev/null)
        or begin
            echo "failed to create herdr workspace"
            return 1
        end

        if command -q jq
            set target_id (echo "$created" | jq -r '.result.workspace.workspace_id // empty')
            set -l root_pane (echo "$created" | jq -r '.result.root_pane.pane_id // empty')

            # Tab 1: editor (mirror t.fish window 1)
            if test -n "$root_pane"
                if command -q nvim
                    herdr pane run "$root_pane" nvim >/dev/null
                else if command -q vim
                    herdr pane run "$root_pane" vim >/dev/null
                end
            end

            # Tab 2: coding agent (numeric label like other tabs)
            set -l agent_kind
            if command -q claude
                set agent_kind claude
            else if command -q pi
                set agent_kind pi
            else if command -q opencode
                set agent_kind opencode
            end

            if test -n "$agent_kind"
                set -l tab_json
                set tab_json (herdr tab create --workspace "$target_id" --cwd "$dir" --label "2" --no-focus 2>/dev/null)
                set -l agent_tab (echo "$tab_json" | jq -r '.result.tab.tab_id // .result.tab_id // empty')
                set -l agent_pane (echo "$tab_json" | jq -r '.result.root_pane.pane_id // .result.pane.pane_id // .result.pane_id // empty')

                # Fall back to pane list if create response has no pane id
                if test -z "$agent_pane"; and test -n "$agent_tab"
                    set agent_pane (
                        herdr pane list --workspace "$target_id" 2>/dev/null \
                            | jq -r --arg tab "$agent_tab" \
                                '.result.panes[]? | select(.tab_id == $tab) | .pane_id' \
                            | head -n1
                    )
                end

                if test -n "$agent_pane"
                    # Pane must be at an interactive shell; agent start launches + detects the agent
                    herdr agent start "$agent_kind" --kind "$agent_kind" --pane "$agent_pane" >/dev/null 2>&1
                    or herdr pane run "$agent_pane" "$agent_kind" >/dev/null 2>&1
                end
            else
                herdr tab create --workspace "$target_id" --cwd "$dir" --label "2" --no-focus >/dev/null 2>&1
            end

            # Tab 3: plain shell
            herdr tab create --workspace "$target_id" --cwd "$dir" --label "3" --no-focus >/dev/null 2>&1
        end
    end

    # Optionally close the workspace we left (t.fish kills previous tmux session)
    if test "$kill_previous" = yes
        and test -n "$previous_workspace"
        and test -n "$target_id"
        and test "$previous_workspace" != "$target_id"
        herdr workspace close "$previous_workspace" >/dev/null 2>&1
    end

    # Outside the herdr UI, attach so the focused workspace is visible
    if not set -q HERDR_ENV
        herdr
    end
end
