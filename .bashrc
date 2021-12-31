# Appended to .bashrc by Chris

# if in wsl
if [[ -x "$(command -v wslpath)" ]]; then
    export WINHOME=$(wslpath "$(wslvar USERPROFILE)")

    # if interactive and stdin
    if [[ -t 0 && $- = *i* ]]
    then
        eval `keychain --eval --agents ssh id_ed25519`
        stty -ixon
    fi
fi

#cd $HOME && tmux a || tmux
cd $HOME && fish

