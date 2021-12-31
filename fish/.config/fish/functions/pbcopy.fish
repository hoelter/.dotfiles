function pbcopy
    read -z text
    echo "Copying input to clipboard."

    # Macos
    if type -q /usr/bin/pbcopy
        echo $text | /usr/bin/pbcopy
        return
    end

    # WSL
    if type -q clip.exe
        echo $text | clip.exe
        return
    end

    # Add x-clip check in here
    echo 'Clipboard command not found.'
end

