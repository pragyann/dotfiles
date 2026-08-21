local ok, jdtls = pcall(require, 'jdtls')
if not ok then
    return
end

-- Falls back to the file's own directory when no project marker is found,
-- so a loose folder of .java files still gets jdtls attached.
local root_dir = require('jdtls.setup').find_root({ '.git', 'pom.xml', 'build.gradle' })
    or vim.fn.expand('%:p:h')

local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace/' .. project_name

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = cmp_ok
    and cmp_nvim_lsp.default_capabilities()
    or vim.lsp.protocol.make_client_capabilities()

jdtls.start_or_attach({
    cmd = { 'jdtls', '-data', workspace_dir },
    root_dir = root_dir,
    capabilities = capabilities,
})
