if test -e /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# mise installation
if type -q mise
    mise activate fish | source
end

# Disable greeting message
set fish_greeting

# fzf bindings
# Run `fzf_configure_bindings --help` for more information
fzf_configure_bindings --directory=\ct

########################################
# General env
#######################################
set -gx GPG_TTY (tty)

# GO installation
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# Rust installation
set -gx PATH $PATH $HOME/.cargo/bin

# Vim all the things
set -gx VISUAL "vim"
set -gx EDITOR $VISUAL

# Start tmux when not set
if status is-interactive
and not set -q TMUX
    exec tmux
end

# Make ssh use yubikey-agent
set -gx SSH_AUTH_SOCK "$(brew --prefix)/var/run/yubikey-agent.sock"

# Set locale
set -gx LC_ALL en_US.UTF-8

# Configure FZF to use fd
set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f'

# gcloud installation
set -gx PATH $PATH /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN true

# zoxide installation
zoxide init fish | source

########################################
# GitLab
#######################################
set -gx VAULT_ADDR https://vault.ops.gke.gitlab.net
set -gx VAULT_PROXY_ADDR socks5://localhost:18200

########################################
# General abbreviations
#######################################
abbr -a ll ls -la
abbr -a k kubectl
abbr -a kc kubectx
abbr -a cl clear
abbr -a gcl gcloud
abbr -a tf terraform
abbr -a n lima nerdctl
abbr -a l limactl
abbr -a d docker
abbr -a v vim

########################################
# Git abbreviations
########################################
abbr -a g git
abbr -a ga git add -p
abbr -a gaa git add --all
abbr -a gl 'git log --pretty=format:"%C(yellow)%H | %ad%Cred%d | %Creset%s%Cblue | [%cn] [%ae]" --decorate --date=short'
abbr -a gc git commit -v -s
abbr -a gch git checkout
abbr -a gcf git commit -v --fixup
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gs git status -s
abbr -a gss git status
abbr -a gp git push
abbr -a gpf git push --force-with-lease
abbr -a gsw git switch
abbr -a gr git restore
abbr -a gcp git cherry-pick
abbr -a gb git branch
