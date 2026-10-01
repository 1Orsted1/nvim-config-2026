-- lspconfig lists compound filetypes (yaml.docker-compose, ...) that Neovim never sets;
-- plain yaml covers those files and keeps checkhealth quiet
return { filetypes = { "yaml" } }
