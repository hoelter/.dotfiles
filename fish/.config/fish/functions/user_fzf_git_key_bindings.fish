function user_fzf_git_key_bindings
    function fzf-select-branch-name -d "Select git branch name"
        git for-each-ref --sort=-committerdate --color=always --format='%(color:red bold)%(refname:short) %(color:reset)%(color:blue)%(committerdate:short) %(committerdate:relative) %(color:green)%(authorname) %(color:reset)%(subject)' | fzf-tmux -p  95%,80% --reverse --no-sort | cut -d " " -f 1 | rev | cut -d "/" -f 1 | rev | xargs | read -l result
        and commandline -it -- $result
        commandline -f repaint
    end

    function fzf-select-commit-hash -d "Select git commit hash"
        git lg | fzf-tmux -p  95%,80% --reverse --no-sort | sed 's/.*\*[ |]*\(\S*\).*/\1/' | xargs | read -l result
        and commandline -it -- $result
        commandline -f repaint
    end

    bind -M insert \cgb fzf-select-branch-name
    bind -M insert \cgl fzf-select-commit-hash
end
