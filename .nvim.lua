local racket_group = vim.api.nvim_create_augroup("RacketProjectConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    desc = "Racket file settings",
    group = racket_group,
    pattern = { "racket" },
    callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.list = true
        vim.opt_local.listchars = "extends:»"
        vim.opt_local.makeprg = "racket %"
    end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
    desc = "Insert #lang sicp boilerplate into new Racket files",
    group = racket_group,
    pattern = "*.rkt",
    callback = function()
        vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#lang sicp", "" })
        vim.api.nvim_win_set_cursor(0, { 3, 0 })
        vim.cmd.startinsert()
    end,
})
