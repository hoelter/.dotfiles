function fish_user_key_bindings
    # Initialize fzf key bindings
    fzf --fish | source
    
    # Set up custom key bindings
    bind "ç" fzf-cd-widget                    # Alt+C for fzf directory search
    bind \es '~/.local/bin/tmux-sessionizer'  # Alt+S for tmux sessionizer
    
    # Initialize git-specific fzf bindings
    user_fzf_git_key_bindings
end
