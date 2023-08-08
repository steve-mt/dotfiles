if test -e /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# ASDF installation
# set -gx ASDF_DIR (brew --prefix asdf)/libexec # ASDF gets confused where to find the executable
# source (brew --prefix asdf)/libexec/asdf.fish
# RTX installation
if type -q rtx
    rtx activate fish | source
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

# `nnn` settings
# Make `nnn` open file with $EDITOR
set -gx NNN_USE_EDITOR 1
# Show hidden files
set -gx NNN_OPTS "H"

# Configure FZF to use fd
set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f'

# gcloud installation
set -gx PATH $PATH /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN true

# rancher desktop
set -gx PATH $PATH $HOME/.rd/bin

# zoxide installation
zoxide init fish | source

########################################
# GitLab
#######################################
if [ $(hostname) = "steve-mbp-gitlab.local" ]
    set -gx VAULT_ADDR https://vault.ops.gke.gitlab.net
    set -gx VAULT_PROXY_ADDR socks5://localhost:18200
end

########################################
# General abbreviations
#######################################
abbr -a ll ls -la
abbr -a va vagrant
abbr -a k kubectl
abbr -a kc kubectx
abbr -a cl clear
abbr -a o orka
abbr -a gcl gcloud
abbr -a tf terraform
abbr -a lin lima nerdctl
abbr -a l limactl
abbr -a n nerdctl
abbr -a d docker

########################################
# Git abbreviations
########################################
abbr -a g git
abbr -a ga git add
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
abbr -a bdiff 'git log --pretty=format:"%C(yellow)%H | %ad%Cred%d | %Creset%s%Cblue | [%cn] [%ae]" --abbrev-commit --date=relative'
abbr -a gcp git cherry-pick
abbr -a gb git branch

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/steve/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
