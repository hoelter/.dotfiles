function fish_user_key_bindings
    fish_vi_key_bindings

    fzf_key_bindings
    # ensure alt c triggers fzf cd function
    bind -M insert "ç" fzf-cd-widget

    user_fzf_git_key_bindings

    bind -M default \es 'tmux-sessionizer'
    bind -M insert \es 'tmux-sessionizer'
end
