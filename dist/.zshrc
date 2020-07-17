# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/cli-histfile
HISTSIZE=50000
SAVEHIST=50000

# End of lines configured by zsh-newuser-install

# Key bindings

typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Plugins

# sane zplug installation defaults
if [[ -z "$ZPLUG_HOME" ]]; then
  ZPLUG_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zplug"
fi
if [[ -z "$ZPLUG_CACHE_DIR" ]]; then
  ZPLUG_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zplug"
fi

# Ensure zplug is installed
if [[ ! -d "$ZPLUG_HOME" ]]; then
  git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
  source "$ZPLUG_HOME/init.zsh" && zplug --self-manage update
else
  source "$ZPLUG_HOME/init.zsh"
fi

zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "zsh-users/zsh-history-substring-search", defer:3 # (like fish)
# zplu" 'zsh-users/zsh-autosuggestions" # (like fish)

zplug "zsh-users/zsh-completions", depth:1 # more completions

zplug "mdumitru/fancy-ctrl-z"

# zplug 'Tarrasch/zsh-autoenv'
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


# see zshoptions(1) for details on what these do
# see also zshexpn(1) for details on how globbing works
setopt append_history # better concurrent shell history sharing
setopt auto_pushd # cd foo; cd bar; popd --> in foo again
setopt complete_in_word # more intuitive completions
setopt no_beep # BEEP
setopt extended_glob # better globs
setopt extended_history # better history
# setopt glob_complete # (see manual for description & tradeoffs)
setopt glob_star_short # ** means **/*, **/ means directory only **
setopt hist_expire_dups_first # don't fill your history as quickly with junk
setopt hist_ignore_space # ` command` doesn't save to history
setopt hist_subst_pattern # better globs / parameter expansion
setopt hist_reduce_blanks # `a  b` normalizes to `a b` in history
setopt hist_verify # reduce oops I sudoed the wrong thing
setopt interactive_comments # so pasting live to test works
setopt ksh_glob # better globs
setopt long_list_jobs # easier to read job stuff
setopt null_glob # sane globbing
setopt pipe_fail # fail when the first command in a pipeline fails
setopt share_history # better concurrent shell history sharing
setopt no_rm_star_silent # confirm on `rm *` (default, but let's be safe)
setopt prompt_cr prompt_sp # don't clobber output without trailing newlines
# setopt rm_star_wait # wait after confirmation on `rm *` to allow ^C

# see zshmodules(1)
zmodload -Fm zsh/files b:zf_\* # emergency file manip under zf_*
zmodload zsh/complist # completion menus
zmodload zsh/mathfunc # better mathematical evaluation
zmodload zsh/termcap 2>/dev/null # terminal resources (if available)
zmodload zsh/terminfo 2>/dev/null # terminal resources (if available)

# see zshcontrib(1)
autoload -Uz zargs # like xargs, but works with globs
autoload -Uz zcalc # like bc, but uses Zsh mathematical evaluation
autoload -Uz zmathfunc; zmathfunc # better mathematical evaluation
autoload -Uz zmv # like mv, but uses patterns (`zmv '(*).lis' '$1.txt'`)

zstyle ':completion:*' menu yes # complete with a nicer menu

# more descriptive time
TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M MB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'

alias sudo='sudo ' # make sudo work with aliases
eval "$(dircolors -b)" # ls colors
alias grep='grep --color=auto ' # in color
alias ls='ls --color=auto -F ' # in color & with classifiers
alias tree='tree -F ' # with classifiers

# keyboard bindings (thanks http://zshwiki.org/home/zle/bindkeys )
#
# if Zsh isn't working with your keyboard properly, try the following:
#   autoload -Uz zkbd; zkbd
# follow the prompts, and restart if necessary.
# the file name printed at the end should match the output of:
#   echo - "${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE"
# move the file if necessary.
typeset -g -A key
load-bindkeys() {
  local zkbd_file="${ZDOTDIR:-$HOME}/.zkbd/${1:-$TERM-$VENDOR-$OSTYPE}"
  if [[ -e "$zkbd_file" ]]; then source "$zkbd_file"; fi

  _key-set() {
    local k="$1"; shift
    if (( ${+key[$k]} )); then return; fi
    while (( ${+1} )); do
      1="$(cat -v <<< "$1")"
      # print -r "key: changing $k from ${(q+)key[$k]} to ${(q+)1}"
      key[$k]="$1"
      if [[ -n "$1" ]]; then break; else shift; fi
    done
  }

  _key-set F1 "$terminfo[kf1]" "$termcap[k1]"
  _key-set F2 "$terminfo[kf2]" "$termcap[k2]"
  _key-set F3 "$terminfo[kf3]" "$termcap[k3]"
  _key-set F4 "$terminfo[kf4]" "$termcap[k4]"
  _key-set F5 "$terminfo[kf5]" "$termcap[k5]"
  _key-set F6 "$terminfo[kf6]" "$termcap[k6]"
  _key-set F7 "$terminfo[kf7]" "$termcap[k7]"
  _key-set F8 "$terminfo[kf8]" "$termcap[k8]"
  _key-set F9 "$terminfo[kf9]" "$termcap[k9]"
  _key-set F10 "$terminfo[kf10]" "$termcap[F1]"
  _key-set F11 "$terminfo[kf11]" "$termcap[F2]"
  _key-set F12 "$terminfo[kf12]" "$termcap[F3]"
  _key-set Backspace "$terminfo[kbs]" "$termcap[kb]"
  _key-set Insert "$terminfo[kich1]" "$termcap[kI]"
  _key-set Home "$terminfo[khome]" "$termcap[kh]"
  _key-set PageUp "$terminfo[kpp]" "$termcap[kP]"
  _key-set Delete "$terminfo[kdch1]" "$termcap[kD]"
  _key-set End "$terminfo[kend]" "$termcap[@7]"
  _key-set PageDown "$terminfo[knp]" "$termcap[kN]"
  _key-set BackTab "''${terminfo[cbt]}" "''${termcap[bt]}"
  _key-set Tab "''${terminfo[ht]}" "''${termcap[ta]}"
  _key-set Up "$terminfo[kcuu1]" "$termcap[ku]"
  _key-set Left "$terminfo[kcub1]" "$termcap[kl]"
  _key-set Down "$terminfo[kcud1]" "$termcap[kd]"
  _key-set Right "$terminfo[kcuf1]" "$termcap[kr]"

  [[ -n "${key[BackTab]}" ]] && bindkey -M menuselect "${key[BackTab]}" reverse-menu-complete
  # search in completion menus with `?` & `/`
  bindkey -M menuselect '/' history-incremental-search-backward
  bindkey -M menuselect '?' history-incremental-search-forward

  # zsh-history-substring search setup (remove if not using that plugin)
  [[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" history-substring-search-up
  [[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

  unset -f _key-set
}
load-bindkeys

# make sure term is in application mode when zle is active (for terminfo)
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  zle-line-init() { echoti smkx }; zle -N zle-line-init
  zle-line-finish() { echoti rmkx }; zle -N zle-line-finish
fi

#

setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# Completions
autoload -Uz compinit && compinit

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Prompt
eval "$(starship init zsh)"

autoload -U colors && colors

set_right_prompt()
{
  RPROMPT="%{$fg[blue]%}%(1j.✦.)%{$reset_color%}"
}

add-zsh-hook preexec set_right_prompt
