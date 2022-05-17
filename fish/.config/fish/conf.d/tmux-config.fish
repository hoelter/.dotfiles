if status --is-interactive
    if not set -q TMUX_FISH_BINDS
        # set -U TMUX_FISH_BINDS true
        # Launch custom rg finder
        tmux unbind-key -n M-r
        tmux bind-key -n M-r display-popup -h 95% -w 95% -E "rg-fzf"

        # Websearch script
        tmux unbind-key -T root M-f
        tmux bind -T root M-f switch-client -T websearch_table

        tmux unbind-key -T websearch_table g
        tmux bind-key -T websearch_table g display-popup -h 15% -E "websearch google 'https://www.google.com/search?q'"

        # Shortcuts
        tmux unbind-key J
        tmux bind-key -r J run-shell "~/.local/bin/tmux-sessionizer ~/personal/notes"
    end
end
