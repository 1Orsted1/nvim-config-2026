-- pyright (npm-based) over basedpyright: Mason's basedpyright needs Python >= 3.10, system has 3.9.
-- Pick up the project's .venv so imports resolve without activating it first.
return {
  before_init = function(_, config)
    local python = (config.root_dir or vim.fn.getcwd()) .. "/.venv/bin/python"
    if vim.uv.fs_stat(python) then
      config.settings.python = vim.tbl_extend("force", config.settings.python or {}, { pythonPath = python })
    end
  end,
}
