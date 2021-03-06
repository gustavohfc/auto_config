# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Cor do comando ls
#export TERM=xterm-256color
#if [ -f ~/.dircolors ]
#    then eval `dircolors ~/.dircolors`
#fi

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

POWERLEVEL9K_MODE='awesome-fontconfig'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git dnf pip python)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Usar o nvim no lugar do vim
alias vi=nvim
alias vim=nvim


my_dir () {
  local print_dir=${PWD#"$HOME/"}
  if [ "$print_dir" = "$HOME" ] ; then
    echo -n "~"
    return
  fi

  local git_dir="$(git rev-parse --git-dir 2>/dev/null)"
  if [ $git_dir ] ; then
    local project_dir=`dirname $git_dir`
    if [ $project_dir = "." ] ; then
      return # Esta na raiz do projeto
    fi
    project_dir=${project_dir#"$HOME/"}
    print_dir=${print_dir#"$project_dir/"}
  elif [[ "$print_dir" != "/"* ]] ; then
    echo -n "~  "
  else
    echo -n "/  "
    print_dir=${print_dir:1}
  fi

  print_dir=${print_dir//"\/"/"  "}
  echo -n $print_dir
}


# Configuracao do powerline9k #################################################################################################################
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\u250f"
#POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%{%F{249}%}\u2517%{%F{default}%} "
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Configuracao do context
DEFAULT_USER=gustavo

# Configuracao do custom_dir
POWERLEVEL9K_CUSTOM_DIR="my_dir"
POWERLEVEL9K_CUSTOM_DIR_BACKGROUND="10"
POWERLEVEL9K_CUSTOM_DIR_FOREGROUND="white"

# Configuracao do vcs
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_VCS_HIDE_TAGS=true

# Configuracao do dir
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_from_right


POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context vcs dir root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv dir_writable background_jobs status)

###############################################################################################################################################



# Completa clicando TAB apenas uma vez
setopt menu_complete

