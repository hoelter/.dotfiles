function open
    if count $argv > /dev/null
        set finalarg $argv
    else
        read -fz finalarg
    end

    # WSL
    if type -q wslview
        wslview $finalarg
        return
    end

    # Macos check open
    if type -q /usr/bin/open
        /usr/bin/open $finalarg
        return
    end

    echo 'Open command not found.'
end

