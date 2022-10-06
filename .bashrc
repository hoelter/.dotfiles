# Appended to .bashrc by Chris

# if interactive and stdin
if [[ -t 0 && $- = *i* ]]; then
    # if in wsl
    if [[ -x "$(command -v wslpath)" ]]; then
        export WINHOME=$(wslpath "$(wslvar USERPROFILE)")

        # xserver setup
        export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

        # ssh setup
        eval `keychain --eval --agents ssh id_ed25519`
        stty -ixon

        cd $HOME && fish
    # NOT in wsl
    else
        if [[ -x "$(command -v fish)" ]]; then
            # Execute fish if command is present and in an interactive shell
            fish
        fi
    fi
fi

