return {
  'windwp/nvim-autopairs',
  envent = "InsertEnter",
  config = function()
    require('nvim-autopairs').setup({})
  end
}
