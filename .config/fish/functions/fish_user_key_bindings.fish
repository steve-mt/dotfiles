# Enable fzf
function fish_user_key_bindings
  fzf_key_bindings
end

########################################
# General env
#######################################
set -gx GPG_TTY (tty)

# GO installation
set -gx GOPATH $HOME/Code/go
set -gx PATH $PATH $GOPATH/bin

# GitLab installation
set -gx GDKPATH ~/Code/gitlab.com/gitlab-org/gitlab
set -gx PATH $PATH /usr/local/opt/postgresql@9.6/bin
set -gx GDK_RUNIT 1 # For runit to be used
set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig" # For pkg-config to find icu4c you may need to set

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

# Make `nnn` open file with $EDITOR
set -gx NNN_USE_EDITOR 1

########################################
# General abbreviations
#######################################
abbr -a ll ls -la
abbr -a va vagrant
abbr -a dc docker-compose
abbr -a d docker
abbr -a k kubectl
abbr -a grubo 'git diff --name-only --diff-filter=d (git log --merges -1 --pretty=format:%H) | xargs bundle exec rubocop'
abbr -a gcl gcloud

########################################
# Git abbreviations
########################################
abbr -a g git
abbr -a ga git add
abbr -a gaa git add --all
abbr -a gl 'git log --pretty=format:"%C(yellow)%H | %ad%Cred%d | %Creset%s%Cblue | [%cn] [%ae]" --decorate --date=short'
abbr -a gc git commit -v
abbr -a gcf git commit -v --fixup
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gs git status -s
abbr -a gss git status
abbr -a gp git push -u
abbr -a gsw git switch
abbr -a gr git restore
abbr -a bdiff 'git log --pretty=format:"%C(yellow)%H | %ad%Cred%d | %Creset%s%Cblue | [%cn] [%ae]" --abbrev-commit --date=relative'
abbr -a gcp git cherry-pick
