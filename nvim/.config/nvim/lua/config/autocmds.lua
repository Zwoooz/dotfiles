-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local colors = {}
    local f = io.open(os.getenv("HOME") .. "/.cache/wal/colors-wal.vim", "r")
    if not f then
      return
    end
    for line in f:lines() do
      local name, value = line:match('^let (color%d+)%s*=%s*"(#%x+)"')
      if name and value then
        colors[name] = value
      end
      local sname, svalue = line:match('^let (%a+)%s*=%s*"(#%x+)"')
      if sname and svalue then
        colors[sname] = svalue
      end
    end
    f:close()

    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = colors.color8, bg = "NONE", italic = true })
    vim.api.nvim_set_hl(0, "NonText", { fg = colors.color8, bg = "NONE" })
    vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.color7, bg = colors.color0 })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.color0, bg = colors.color6 })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors.color8 })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = colors.color0 })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.color7, bg = colors.color0 })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.color6, bg = colors.color0 })
    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = colors.color7, bg = colors.color0 })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = colors.color2, bg = colors.color0 })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = colors.color2, bg = colors.color0 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = colors.color4 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = colors.color4 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = colors.color15 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = colors.color3 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = colors.color5 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = colors.color5 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = colors.color5 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = colors.color1 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = colors.color13 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = colors.color15 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = colors.color15 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = colors.color3 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = colors.color3 })
    vim.api.nvim_set_hl(0, "BlinkCmpKindType", { fg = colors.color5 })
    vim.api.nvim_set_hl(0, "SnacksPicker", { bg = colors.color0 })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { bg = colors.color0 })
    vim.api.nvim_set_hl(0, "SnacksPickerTitle", { bg = colors.color0 })
    vim.api.nvim_set_hl(0, "SnacksExplorerTitle", { bg = colors.color0 })
    vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = colors.color0 })
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = colors.color0 })
  end,
})
