return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    return {
      { ",t", function() harpoon:list():add() end, desc = "Harpoon add file" },
      { ",j", function() harpoon.ui:toggle_quick_menu(harpoon:list(), { ui_width_ratio = 0.95 }) end, desc = "Harpoon menu" },
      { ",f", function() harpoon:list():select(1) end, desc = "Harpoon file 1" },
      { ",d", function() harpoon:list():select(2) end, desc = "Harpoon file 2" },
      { ",s", function() harpoon:list():select(3) end, desc = "Harpoon file 3" },
      { ",a", function() harpoon:list():select(4) end, desc = "Harpoon file 4" },
      { ",r", function() harpoon:list():select(5) end, desc = "Harpoon file 5" },
      { ",e", function() harpoon:list():select(6) end, desc = "Harpoon file 6" },
      { ",w", function() harpoon:list():select(7) end, desc = "Harpoon file 7" },
      { ",q", function() harpoon:list():select(8) end, desc = "Harpoon file 8" },
    }
  end,
  config = function()
    require("harpoon"):setup({
      settings = {
          save_on_toggle = true
      }
    })
  end,
}
