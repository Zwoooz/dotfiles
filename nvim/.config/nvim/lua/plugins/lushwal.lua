return {
  "oncomouse/lushwal.nvim",
  cmd = { "LushwalCompile" },
  dependencies = {
    { "rktjmp/lush.nvim" },
    { "rktjmp/shipwright.nvim" },
  },
  lazy = false,

  config = function()
    -- set up lushwal config
    vim.g.lushwal_configuration = {
      color_overrides = function(colors)
        local overrides = {}
        return vim.tbl_extend("force", colors, overrides)
      end,
    }

    -- Set CursorLine after colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
      end,
    })
  end,
}
