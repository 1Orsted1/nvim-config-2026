-- Make lua_ls understand this config: Neovim's LuaJIT and the `vim` API
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
    },
  },
}
