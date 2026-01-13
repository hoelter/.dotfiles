function user_fzf_git_key_bindings
    function fzf-select-branch-name -d "Select git branch name"
        git for-each-ref --sort=-committerdate --color=always --format='%(color:red bold)%(refname:short) %(color:reset)%(color:blue)%(committerdate:short) %(committerdate:relative) %(color:green)%(authorname) %(color:reset)%(subject)' | fzf --reverse --no-sort | cut -d " " -f 1 | rev | cut -d "/" -f 1 | rev | xargs | read -l result
        and commandline -it -- $result
        commandline -f repaint
    end

    function fzf-select-commit-hash -d "Select git commit hash"
            git l | fzf --reverse --no-sort | sed -E 's/.*\*[ |]*(\S*).*/\1/' | xargs | read -l result
            and commandline -it -- $result
            commandline -f repaint
        # if set -q MACBOOK
        #     git l | fzf --reverse --no-sort | gsed 's/.*\*[ |]*\(\S*\).*/\1/' | xargs | read -l result
        #     and commandline -it -- $result
        #     commandline -f repaint
        # else
        #     git l | fzf --reverse --no-sort | sed 's/.*\*[ |]*\(\S*\).*/\1/' | xargs | read -l result
        #     and commandline -it -- $result
        #     commandline -f repaint
        # end
    end

    bind \cgb fzf-select-branch-name
    bind \cgl fzf-select-commit-hash
end
