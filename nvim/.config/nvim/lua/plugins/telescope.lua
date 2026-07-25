return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            'nvim-telescope/telescope-ui-select.nvim',
        },

        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            telescope.setup({
                defaults = {
                    layout_strategy = 'flex',

                    layout_config = {
                        flex = {
                            flip_columns = 120,
                        },

                        horizontal = {
                            preview_width = 0.6,
                        },

                        vertical = {
                            preview_height = 0.7,
                        },

                        width = 0.9,
                        height = 0.9,
                    },

                    preview = {
                        treesitter = true,
                    },
                },

                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')

            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end, { desc = 'Find files' })

            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {
                desc = 'Live grep',
            })

            vim.keymap.set('n', '<leader>fb', builtin.buffers, {
                desc = 'Find buffers',
            })

            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {
                desc = 'Help tags',
            })
        end,
    },
}
