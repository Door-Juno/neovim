return {
      {
    -- LSP 설정의 핵심 플러그인
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP 서버 자동 설치를 위한 플러그인
      {
        "mason-org/mason.nvim",
        config = function()
          require("mason").setup()
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },

      -- ...기타 LSP 관련 플러그인 (자동완성 등)...
    },
    config = function()
      -- mason-lspconfig 설정
      local capabilities = require('cmp_nvim_lsp').default_capabilities() -- 자동완성 플러그인 사용 시

      require("mason-lspconfig").setup({
        -- 여기에 자동으로 설치하고 싶은 LSP 서버 목록을 추가합니다.
        -- 예를 들어, Python, C/C++, Lua, TypeScript 서버
        ensure_installed = { "pyright", "clangd", "lua_ls", "tsserver" },
      })

      -- 각 LSP 서버에 대한 개별 설정
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- 기본 설정
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["lua_ls"] = function() -- 특정 서버(lua_ls)에 대한 추가 설정
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  -- Neovim 관련 전역 변수(vim)를 인식시킵니다.
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      })
    end,
  },
}

