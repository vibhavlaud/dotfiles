local yank_group = vim.api.nvim_create_augroup("Yank", { clear = true })
local python_group = vim.api.nvim_create_augroup("python_group", { clear = true })
local trim_group = vim.api.nvim_create_augroup("trim_group", { clear = true })
local lsp_attach_group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = python_group,
    pattern = "*.py",
    callback = function()
        vim.lsp.buf.format()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = trim_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = 'LSP: Disable hover capability from Ruff',
})
