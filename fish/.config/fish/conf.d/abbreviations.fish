if status --is-interactive
    abbr -a -g v "nvim"
    abbr -a -g vim "nvim"

    abbr -a -g rfish "source ~/.config/fish/config.fish"
    abbr -a -g weather "curl wttr.in"
    abbr -a -g myip "curl ifconfig.me"

    abbr -a -g g "git"
    abbr -a -g gp "git push"
    abbr -a -g gu "git pull"
    abbr -a -g gs "git status"
    abbr -a -g gl "git l"
    abbr -a -g gc "git ca"
    abbr -a -g gf "git fetch"
    abbr -a -g gd "git diff"
    abbr -a -g ga "git add -A && git commit -m 'Quick commit'"
    abbr -a -g gconfig "git config --global --list"
    abbr -a -g vdiff "nvim -p (git diff --name-only (git merge-base HEAD \"$REVIEW_BASE\")) +\"tabdo Gvdiffsplit $REVIEW_BASE\""
    abbr -a -g gfiles "git diff --name-only (git merge-base HEAD \"$REVIEW_BASE\")"
    abbr -a -g gstat "git diff --stat (git merge-base HEAD \"$REVIEW_BASE\")"

    abbr -a -g l "ls -lAF"
    abbr -a -g .. "cd .."
    abbr -a -g ... "cd ../.."
    abbr -a -g .... "cd ../../.."
    abbr -a -g ..... "cd ../../../.."
    abbr -a -g - "cd -"

    abbr -a -g bye "shutdown.exe -s -f -t 0"
    abbr -a -g pkm "pkill mono"
    abbr -a -g rg "rg -M 250 -Sp"

    abbr -a -g c "bc -l"

    # https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
    abbr -a -g wsl-drop-cache "sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && printf '\n%s\n' 'Ram-cache Cleared'\""
end
