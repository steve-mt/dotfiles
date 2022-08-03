eval (/opt/homebrew/bin/brew shellenv)
source (brew --prefix asdf)/asdf.fish

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

# Make ssh use gpg
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

# Set locale
set -gx LC_ALL en_US.UTF-8

# `nnn` settings
# Make `nnn` open file with $EDITOR
set -gx NNN_USE_EDITOR 1
# Show hidden files
set -gx NNN_OPTS "H"

# Configure FZF to use fd
set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f'

# Source optinal configuration for installed tools
set gcloud_instllation '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
if test -e $gcloud_instllation
    source $gcloud_instllation
    set -gx USE_GKE_GCLOUD_AUTH_PLUGIN true
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
abbr -a n lima nerdctl
abbr -a l limactl

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
