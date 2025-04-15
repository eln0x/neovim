-- Neovim Terraform
-- stylua: ignore
--if true then return {} end

return {
    -- 🧩 Recommended conditional loading (only when needed)
    recommended = function()
        return LazyVim.extras.wants({
            ft = { "terraform", "hcl" },
            root = ".terraform",
        })
    end,
    -- 🌳 Treesitter: Syntax highlighting & parsing
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "terraform", "hcl" } },
    },
    -- 🔧 Mason: Tool installation manager
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            local new = {
                "terraform-ls",     -- language server protocol
                "terraform",        -- formatter
                "tflint",           -- linter
            }
            for _, tool in ipairs(new) do
                if not vim.tbl_contains(opts.ensure_installed, tool) then
                    table.insert(opts.ensure_installed, tool)
                end
            end
        end,
    },
    -- 🧹 Linting: Code quality checks
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                terraform = { "terraform_validate", "tflint" },
                tf = { "terraform_validate", "tflint" },
            },
            linters = {
                terraform_validate = {
                    cmd = "terraform",
                    args = { "validate", "-no-color" },
                    stdin = false,
                },
                tflint = {
                    cmd = "tflint",
                    args = { "--format", "json" },
                    stdin = false,
                },
            },
        },
    },
    -- ✨ Conform: Formatting
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                hcl = { "packer_fmt" },
                terraform = { "terraform_fmt" },
                tf = { "terraform_fmt" },
            },
            formatters = {
                terraform_fmt = {
                    command = "terraform",
                    args = { "fmt", "-" },
                    stdin = true,
                },
            },
        }
    },
    -- 🪄 None-ls: Formatters & Linters via LSP.
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.formatting.terraform_fmt,
            })
        end,
    },
    -- 🧠 LSP: Language server configuration
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                terraformls = {
                    cmd = { "terraform-ls", "serve" },
                    filetypes = { "terraform", "tf", "tfvars" },
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(".terraform", ".git")(fname)
                            or vim.fs.dirname(fname)
                    end,
                    settings = {
                        terraform = {
                            languageServer = {
                                experimentalFeatures = {
                                    validateOnSave = true,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    -- 🌍 Icons for Terraform-related files
    {
        "nvim-mini/mini.icons",
        optional = true,
        opts = {
            filetype = {
                terraform = { glyph = "", hl = "MiniIconsGreen" },
                hcl = { glyph = "", hl = "MiniIconsGrey" },
            },
        },
    },
    -- 🌐 Telescope docs
    {
        "nvim-telescope/telescope.nvim",
        optional = true,
        specs = {
            {
                "ANGkeith/telescope-terraform-doc.nvim",
                ft = { "terraform", "hcl" },
                config = function()
                    LazyVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("terraform_doc")
                    end)
                end,
            },
            {
                "cappyzawa/telescope-terraform.nvim",
                ft = { "terraform", "hcl" },
                config = function()
                    LazyVim.on_load("telescope.nvim", function()
                        require("telescope").load_extension("terraform")
                    end)
                end,
            },
        },
    },
}

-- vim: ts=4 sts=4 sw=4 et
