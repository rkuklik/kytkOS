{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    dotDir = ".config/zsh";
    defaultKeymap = "emacs";
    shellAliases = {
      ls = "ls --color=auto --group-directories-first -v";
      wget = ''wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'';
    };
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      path = "$XDG_STATE_HOME/zsh/zhistory";
      append = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
      extended = true;
    };
    initExtraFirst =
      # sh
      ''
        WORDCHARS=''${WORDCHARS//\/[&.;]}
      '';
    initExtraBeforeCompInit =
      # sh
      ''
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
        zstyle ':completion:*' rehash true                              # automatically find new executables in path
        # Speed up completions
        zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path ~/.zsh/cache

        ## keybindings section
        bindkey '\e[1~' beginning-of-line            # Home
        bindkey '\e[7~' beginning-of-line            # Home
        bindkey '\e[H'  beginning-of-line            # Home
        bindkey '\eOH'  beginning-of-line            # Home

        bindkey '\e[4~' end-of-line                  # End
        bindkey '\e[8~' end-of-line                  # End
        bindkey '\e[F ' end-of-line                  # End
        bindkey '\eOF'  end-of-line                  # End

        if [[ "$terminfo[khome]" != "" ]]; then
          bindkey "$terminfo[khome]" beginning-of-line
        fi
        if [[ "$terminfo[kend]" != "" ]]; then
          bindkey "$terminfo[kend]" end-of-line                       # [end] - go to end of line
        fi

        bindkey '^[[2~' overwrite-mode                                  # insert key
        bindkey '^[[3~' delete-char                                     # delete key
        bindkey '^[[c'  forward-char                                    # right key
        bindkey '^[[d'  backward-char                                   # left key
        bindkey '^[[5~' history-beginning-search-backward               # page up key
        bindkey '^[[6~' history-beginning-search-forward                # page down key
        if [[ "$terminfo[kcuu1]" != "" ]]; then
          bindkey "$terminfo[kcuu1]" history-substring-search-up        # up key
        fi
        if [[ "$terminfo[kcud1]" != "" ]]; then
          bindkey "$terminfo[kcud1]" history-substring-search-down      # down key
        fi

        # navigate words with ctrl+arrow keys
        bindkey '^[[1;5C' forward-word               # C-Right
        bindkey '^[0c'    forward-word               # C-Right
        bindkey '^[[5C'   forward-word               # C-Right

        bindkey '^[[1;5D' backward-word              # C-Left
        bindkey '^[0d'    backward-word              # C-Left
        bindkey '^[[5D'   backward-word              # C-Left

        bindkey '^h' backward-kill-word                                 # delete previous word with ctrl+backspace
        bindkey '^[[z' undo                                             # shift+tab undo last action
      '';
    completionInit =
      # sh
      ''
        autoload -U compinit colors zcalc add-zsh-hook
        compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
      '';
    initExtra =
      # sh
      ''
        setopt correct                                                  # Auto correct mistakes
        setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
        setopt nocaseglob                                               # Case insensitive globbing
        setopt rcexpandparam                                            # Array expension with parameters
        setopt nocheckjobs                                              # Don't warn about running processes when exiting
        setopt numericglobsort                                          # Sort filenames numerically when it makes sense
        setopt nobeep                                                   # No beep
        setopt appendhistory                                            # Immediately append history instead of overwriting
        setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
        setopt autocd                                                   # if only directory path is entered, cd there.
        setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
        setopt histignorespace                                          # Don't save commands that start with space
      '';
  };
}
