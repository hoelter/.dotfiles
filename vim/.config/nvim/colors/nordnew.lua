-- Port of https://github.com/arcticicestudio/nord-vim

local nord0_gui = "#2E3440"
local nord1_gui = "#3B4252"
local nord2_gui = "#434C5E"
local nord3_gui = "#4C566A"
local nord3_gui_bright = "#616E88"
local nord4_gui = "#D8DEE9"
local nord5_gui = "#E5E9F0"
local nord6_gui = "#ECEFF4"
local nord7_gui = "#8FBCBB"
local nord8_gui = "#88C0D0"
local nord9_gui = "#81A1C1"
local nord10_gui = "#5E81AC"
local nord11_gui = "#BF616A"
local nord12_gui = "#D08770"
local nord13_gui = "#EBCB8B"
local nord14_gui = "#A3BE8C"
local nord15_gui = "#B48EAD"

local nord1_term = 0
local nord3_term = 8
local nord5_term = 7
local nord6_term = 15
local nord7_term = 14
local nord8_term = 6
local nord9_term = 4
local nord10_term = 12
local nord11_term = 1
local nord12_term = 11
local nord13_term = 3
local nord14_term = 2
local nord15_term = 5

vim.g.terminal_color_0 = nord1_gui
vim.g.terminal_color_1 = nord11_gui
vim.g.terminal_color_2 = nord14_gui
vim.g.terminal_color_3 = nord13_gui
vim.g.terminal_color_4 = nord9_gui
vim.g.terminal_color_5 = nord15_gui
vim.g.terminal_color_6 = nord8_gui
vim.g.terminal_color_7 = nord5_gui
vim.g.terminal_color_8 = nord3_gui
vim.g.terminal_color_9 = nord11_gui
vim.g.terminal_color_10 = nord14_gui
vim.g.terminal_color_11 = nord13_gui
vim.g.terminal_color_12 = nord9_gui
vim.g.terminal_color_13 = nord15_gui
vim.g.terminal_color_14 = nord7_gui
vim.g.terminal_color_15 = nord6_gui

-- +---------------+
-- +    Config     +
-- +---------------+
local bold = true
local underline = true
local italic = true
-- local italicize_comments = false
local uniform_status_lines = false
local bold_vertical_split_line = false
local cursor_line_number_background = false
local uniform_diff_background = true -- change in vim default which is false

-- +- Git -+
-- Legacy groups for official git.vim and diff.vim syntax are the links
vim.api.nvim_set_hl(0, "DiffAdd", { fg = nord14_gui, bg = nord1_gui })
vim.api.nvim_set_hl(0, "DiffChange", { fg = nord13_gui, bg = nord1_gui })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = nord11_gui, bg = nord1_gui })
vim.api.nvim_set_hl(0, "DiffText", { fg = nord9_gui, bg = nord1_gui })
vim.api.nvim_set_hl(0, "gitconfigVariable", { fg = nord7_gui })
-- END GIT

-- Setup function
local M = {}

function M.setup() end
