fish_add_path $HOME/.local/bin

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# Dev specific
set -gx ASPNETCORE_ENVIRONMENT "Development"
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1

set -gx GOPATH "$HOME/.go"
fish_add_path $GOPATH/bin

if status --is-interactive
    set -gx BAT_THEME Nord
    set -gx PISTOL_CHROMA_FORMATTER terminal256
    set -gx PISTOL_CHROMA_STYLE nord

    set -gx FZF_DEFAULT_COMMAND "fd --type file --hidden --follow --strip-cwd-prefix --ignore-file $HOME/.config/fd/ignore"
    set -gx FZF_DEFAULT_OPTS '--ansi --color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#A3BE8C,fg+:#eceff4,prompt:#81A1C1,hl+:#81A1C1'

    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND "fd --type directory --hidden --follow --strip-cwd-prefix --ignore-file $HOME/.config/fd/ignore"
    set -gx FZF_ALT_C_OPTS "--ansi"
    #set -gx FZF_TMUX 1
    #set -gx FZF_TMUX_OPTS "-p"
end
