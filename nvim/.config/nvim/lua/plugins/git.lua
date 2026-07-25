return {
    ------------------------------------------------------------------------
    -- Git (Fugitive)
    ------------------------------------------------------------------------
    {
        "tpope/vim-fugitive",
        cmd = {
            "Git",
            "G",
            "Gblame",
        },

        keys = {
            { "<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
            { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git Blame" },
        },
    },


    ------------------------------------------------------------------------
    -- GitSigns
    ------------------------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },

        opts = {
            signs = {
                add          = { text = "+" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },

            current_line_blame = false,

            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, {
                        buffer = bufnr,
                        silent = true,
                        desc = desc,
                    })
                end


                ----------------------------------------------------------------
                -- Hunk navigation
                ----------------------------------------------------------------
                map("n", "]c", gs.next_hunk, "Next Git Change")
                map("n", "[c", gs.prev_hunk, "Previous Git Change")


                ----------------------------------------------------------------
                -- Hunk operations
                ----------------------------------------------------------------
                map("n", "<leader>ghs", gs.stage_hunk, "Stage Hunk")
                map("n", "<leader>ghr", gs.reset_hunk, "Reset Hunk")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")


                ----------------------------------------------------------------
                -- Blame
                ----------------------------------------------------------------
                map(
                    "n",
                    "<leader>ghb",
                    gs.toggle_current_line_blame,
                    "Toggle Current Line Blame"
                )
            end,
        },
    },


    ------------------------------------------------------------------------
    -- Diffview
    ------------------------------------------------------------------------
    {
        "sindrets/diffview.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewFileHistory",
        },

        keys = {
            {
                "<leader>gd",
                "<cmd>DiffviewOpen<CR>",
                desc = "Open Diffview",
            },

            {
                "<leader>gq",
                "<cmd>DiffviewClose<CR>",
                desc = "Close Diffview",
            },

            {
                "<leader>gf",
                "<cmd>DiffviewFileHistory %<CR>",
                desc = "File History",
            },

            {
                "<leader>gt",
                "<cmd>DiffviewToggleFiles<CR>",
                desc = "Open Diffview",
            },
        },

        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
                keymaps = {
                    view = {
                        {
                            "n",
                            "<leader>gL",
                            "<cmd>diffget LOCAL<CR>",
                            {
                                desc = "Take Local Change",
                            },
                        },

                        {
                            "n",
                            "<leader>gR",
                            "<cmd>diffget REMOTE<CR>",
                            {
                                desc = "Take Remote Change",
                            },
                        },
                    },
                },
            })
        end,
    },
}
