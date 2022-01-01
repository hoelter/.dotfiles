if not set -q GENERAL_SETTINGS
    set -U GENERAL_SETTINGS true
    set -U fish_greeting "🐟"
    set -U fish_color_autosuggestion FFC473
    set -U fish_color_cancel \x2dr
    set -U fish_color_command FF9400
    set -U fish_color_comment A63100
    set -U fish_color_cwd green
    set -U fish_color_cwd_root red
    set -U fish_color_end FF4C00
    set -U fish_color_error FFDD73
    set -U fish_color_escape 00a6b2
    set -U fish_color_history_current \x2d\x2dbold
    set -U fish_color_host normal
    set -U fish_color_host_remote yellow
    set -U fish_color_match \x2d\x2dbackground\x3dbrblue
    set -U fish_color_normal normal
    set -U fish_color_operator 00a6b2
    set -U fish_color_param FFC000
    set -U fish_color_quote BF9C30
    set -U fish_color_redirection BF5B30
    set -U fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
    set -U fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
    set -U fish_color_status red
    set -U fish_color_user brgreen
    set -U fish_color_valid_path \x2d\x2dunderline
    set -U fish_pager_color_completion normal
    set -U fish_pager_color_description B3A06D\x1eyellow
    set -U fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
    set -U fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
end

fish_add_path $HOME/.local/bin

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

set -gx FZF_DEFAULT_COMMAND "fd --type file --hidden --follow --color=always --ignore-file $HOME/.config/fd/ignore"
set -gx FZF_DEFAULT_OPTS "--ansi"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type directory --hidden --follow --color=always --ignore-file $HOME/.config/fd/ignore"
set -gx FZF_ALT_C_OPTS "--ansi"

if set -q MACBOOK
    set -gx BAT_THEME Nord
end

if status --is-interactive
    abbr -a -g v "nvim"
    abbr -a -g vim "nvim"

    abbr -a -g rfish "source ~/.config/fish/config.fish"
    abbr -a -g weather "curl wttr.in"
    abbr -a -g myip "curl ifconfig.me"

    abbr -a -g g "git"
    abbr -a -g gsave "git add -A && git commit -m 'quick save' && git push"
    abbr -a -g gla "git config --global --list"
    abbr -a -g dot "git -C $HOME/.dotfiles"
    abbr -a -g dotsave "git -C $HOME/.dotfiles add -A && git -C $HOME/.dotfiles commit -m 'Dotfiles quick save.' && git -C $HOME/.dotfiles push"

    abbr -a -g ll "ls -lAF"
    abbr -a -g bye "shutdown.exe -s -f -t 0"
    abbr -a -g .. "cd .."
    abbr -a -g ... "cd ../.."
    abbr -a -g .... "cd ../../.."
    abbr -a -g ..... "cd ../../../.."

    # https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
    abbr -a -g wsl-drop-cache "sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && printf '\n%s\n' 'Ram-cache Cleared'\""
end
