# https://distrobox.privatedns.org/posts/execute_commands_on_host#integrate-host-with-container-seamlessly
# function fish_command_not_found
#     # "In a container" check
#     if test -e /run/.containerenv -o -e /.dockerenv
#         distrobox-host-exec $argv
#     else
#         __fish_default_command_not_found_handler $argv
#     end
# end
