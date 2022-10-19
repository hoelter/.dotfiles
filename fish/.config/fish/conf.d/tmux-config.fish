if status --is-interactive
    set -gx TMUX_SESSIONIZER_DIRS $HOME/personal $HOME/work $HOME/my-repos $HOME/other-repos

    set tmux_running (pgrep tmux)
    if test -n "$tmux_running"
        # Launch custom rg finder
        tmux unbind-key -n M-r
        tmux bind-key -n M-r display-popup -h 95% -w 95% -E "rg-fzf"

        # Websearch script
        tmux unbind-key -T root M-l
        tmux bind -T root M-l switch-client -T websearch_table

        tmux bind-key -T websearch_table g display-popup -h 15% -E "websearch google 'https://www.google.com/search?q'"
        tmux bind-key -T websearch_table M-g display-popup -h 15% -E "websearch google 'https://www.google.com/search?q'"

        # Shortcuts
        tmux unbind-key -T root M-k
        tmux bind -T root M-k switch-client -T quick_nav_table

        tmux bind-key -T quick_nav_table -r j run-shell "~/.local/bin/tmux-sessionizer ~/personal/notes"
        tmux bind-key -T quick_nav_table -r M-j run-shell "~/.local/bin/tmux-sessionizer ~/personal/notes"
    end
end
