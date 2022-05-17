function open
    if count $argv > /dev/null
        set target_url $argv
    else
        read -fz target_url
    end

    # WSL
    if type -q wslview
        wslview $target_url
        return
    end

    # Macos check open
    if type -q /usr/bin/open
        /usr/bin/open $target_url
        return
    end

    echo 'Open command not found.'
    return 1
end

