function pbcopy
    if count $argv > /dev/null
        set text $argv
    else
        read -fz text
    end

    # WSL
    if type -q clip.exe
        echo $text | clip.exe
        return
    end

    # Macos
    if type -q /usr/bin/pbcopy
        echo $text | /usr/bin/pbcopy
        return
    end

    # Add x-clip check in here
    echo 'Clipboard copy command not found.'
    return 1
end

