function user_fzf_git_key_bindings

  function fzf-select-branch-name -d "Select git branch name"
    git for-each-ref --sort=-committerdate --color=always --format=' %(color:yellow)%(committerdate:short) %(committerdate:relative) %(color:red)%(refname:short) %(color:cyan)%(authorname) %(color:reset)%(subject)' | fzf-tmux -p --reverse | rev | cut -d " " -f 1 | cut -d "/" -f 1 | rev | read -lz result
    and commandline -it -- $result
    commandline -f repaint
  end

  bind -M insert \cg fzf-select-branch-name
end
