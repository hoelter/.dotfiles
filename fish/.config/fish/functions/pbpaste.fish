function pbpaste
    # WSL
    if type -q powershell.exe
        powershell.exe Get-Clipboard
        return
    end

    # Macos
    if type -q /usr/bin/pbpaste
        /usr/bin/pbpaste
        return
    end

    # Add x-clip check in here
    echo 'Clipboard paste command not found.'
    return 1
end

