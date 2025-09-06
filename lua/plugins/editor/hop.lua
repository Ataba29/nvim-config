-- lua/plugins/editor/hop.lua - Easy motion/jumping

return {
  "phaazon/hop.nvim",
  branch = "v2",
  event = "BufRead",
  config = function()
    require("hop").setup({
      keys = "etovxqpdygfblzhckisuran",
      quit_key = "<SPC>",
    })

    local keymap = vim.keymap
    local hop = require("hop")
    local directions = require("hop.hint").HintDirection

    -- Better f/F/t/T motions
    keymap.set("", "f", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true, desc = "Hop forward to char" })

    keymap.set("", "F", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true, desc = "Hop backward to char" })

    keymap.set("", "t", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true, desc = "Hop forward before char" })

    keymap.set("", "T", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true, desc = "Hop backward after char" })

    -- Additional hop keymaps
    keymap.set("n", "<leader>hw", "<cmd>HopWord<CR>", { desc = "[H]op to [W]ord" })
    keymap.set("n", "<leader>hl", "<cmd>HopLine<CR>", { desc = "[H]op to [L]ine" })
    keymap.set("n", "<leader>hc", "<cmd>HopChar1<CR>", { desc = "[H]op to [C]haracter" })
    keymap.set("n", "<leader>hp", "<cmd>HopPattern<CR>", { desc = "[H]op to [P]attern" })
    keymap.set("n", "<leader>j", function()
      hop.hint_words()
    end, { desc = "Hop to word" })
    keymap.set("n", "<leader>k", function()
      hop.hint_lines()
    end, { desc = "Hop to line" })
  end,
}