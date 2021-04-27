source (brew --prefix asdf)/asdf.fish

########################################
# General env
#######################################
set -gx GPG_TTY (tty)

# GO installation
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# Rust installation
set -gx PATH $PATH $HOME/.cargo/bin

# GitLab installation
set -gx GDKPATH ~/code/gitlab.com/gitlab-org/gitlab
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

# `nnn` settings
# Make `nnn` open file with $EDITOR
set -gx NNN_USE_EDITOR 1
# Show hidden files
set -gx NNN_OPTS "H"

# Configure FZF to use fd
set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f'

########################################
# General abbreviations
#######################################
abbr -a ll ls -la
abbr -a va vagrant
abbr -a dc docker-compose
abbr -a d docker
abbr -a k kubectl
abbr -a cl clear
abbr -a o orka
abbr -a aws docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli
abbr -a gcl docker run --rm -it -v ~/.config/gcloud:/root/.config/gcloud -v ~/.ssh:/root/.ssh google/cloud-sdk gcloud
abbr -a tf terraform

########################################
# Git abbreviations
########################################
abbr -a g git
abbr -a ga git add
abbr -a gaa git add --all
abbr -a gl 'git log --pretty=format:"%C(yellow)%H | %ad%Cred%d | %Creset%s%Cblue | [%cn] [%ae]" --decorate --date=short'
abbr -a gc git commit -v
abbr -a gch git checkout
abbr -a gcf git commit -v --fixup
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a gs git status -s
abbr -a gss git status
abbr -a gp git push -u
abbr -a gpf git push --force-with-lease
abbr -a gsw git switch
abbr -a gr git restore
abbr -a bdiff 'git log --pretty=format:"%C(yellow)%H | %ad%Cred%d | %Creset%s%Cblue | [%cn] [%ae]" --abbrev-commit --date=relative'
abbr -a gcp git cherry-pick
