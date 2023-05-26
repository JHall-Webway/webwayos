vim.o.relativenumber = true;
vim.o.shiftwidth = 2;
vim.cmd.colorscheme'gruvbox'
vim.diagnostic.config{ virtual_text = false }

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lsp_lines'.setup()
require'lualine'.setup{}
require'lspconfig'.rnix.setup{ capabilities = capabilities }
require'lspconfig'.lua_ls.setup { settings = { Lua = {
  runtime = { version = 'LuaJIT' },
  diagnostics = { globals = {
    'vim',
    'awesome',
    'root',
    'client',
    'screen',
  }},
  workspace = {
    library = vim.api.nvim_get_runtime_file("", true),
    checkThirdParty = false,
  },
  telemetry = { enable = false },
}}, capabilities = capabilities }

require'nvim-treesitter.configs'.setup{
  highlight = { enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
}

local cmp = require'cmp'
cmp.setup{
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
  }),
  formatting = {
    format = require'lspkind'.cmp_format{
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
      before = function (entry, vim_item)
      	return vim_item
      end,
    }
  }
}
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
