let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofumpt'],
\   'json': ['jq'],
\   'terraform': ['terraform'],
\   'yaml': ['yamlfix'],
\   'ruby': ['rubocop'],
\   'rust': ['rustfmt'],
\   'sh': ['shfmt'],
\}
let g:ale_linters = {
\   'json': ['jq'],
\}
let g:ale_fix_on_save = 1
