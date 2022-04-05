function user_fzf_git_key_bindings

  function fzf-select-branch-name -d "Select git branch name"
    git for-each-ref --sort=-committerdate --color=always --format='%(color:red)%(refname:short) %(color:yellow)%(committerdate:short) %(committerdate:relative) %(color:cyan)%(authorname) %(color:reset)%(subject)' | fzf-tmux -p  95%,80% --reverse | cut -d " " -f 1 | rev | cut -d "/" -f 1 | rev | xargs | read -l result
    and commandline -it -- $result
    commandline -f repaint
  end

  bind -M insert \cgb fzf-select-branch-name
end
