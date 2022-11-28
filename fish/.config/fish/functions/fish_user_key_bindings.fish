function fish_user_key_bindings
    # fish_vi_key_bindings
    fzf_key_bindings

    # for mode in insert default visual
    #     bind -M $mode \cf forward-char
    # end

    # ensure alt c triggers fzf cd function
    bind "ç" fzf-cd-widget

    user_fzf_git_key_bindings

    bind \es '~/.local/bin/tmux-sessionizer'
    bind \es '~/.local/bin/tmux-sessionizer'
end
