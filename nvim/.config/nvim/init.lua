-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd("colorscheme lushwal")
require("lushwal").add_reload_hook({
  vim.cmd("LushwalCompile"),
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.sh",
  callback = function()
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/bin/bash", "" })
  end,
})
