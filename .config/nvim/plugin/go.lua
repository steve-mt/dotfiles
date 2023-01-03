require('lspconfig').gopls.setup({
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            env = {
              GOFLAGS = "-tags=linux",
            },
        }
    }
})
