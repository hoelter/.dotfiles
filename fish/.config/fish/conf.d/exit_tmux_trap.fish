# Based on: https://github.com/caarlos0/dotfiles.fish/blob/master/tmux/conf.d/tmux-trap.fish
# Will switch to the last active session instead of re-attaching to default when
# a different session exits cia ctrl-d.

function __exit_tmux_trap
	test -z "$NVIM_LISTEN_ADDRESS" || exit
	test (tmux list-windows | wc -l) = 1 || exit
	test (tmux list-panes | wc -l) = 1 || exit
	tmux switch-client -l
end

if status --is-interactive
	trap __exit_tmux_trap EXIT
end
