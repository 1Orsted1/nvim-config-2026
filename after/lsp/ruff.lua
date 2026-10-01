-- Ruff lints/formats; pyright gives richer hover docs, so avoid duplicate popups
return {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}
