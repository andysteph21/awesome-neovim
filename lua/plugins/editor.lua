-- every spec file under config.plugins will be loaded automatically by lazy.nvim
return {

    -- auto pairs
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
        end
    },
    -- comments
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            require("Comment").setup(opts)
        end
    },
    --Neovim motion on speed
    {
        "phaazon/hop.nvim",
        keys = {
            { "f", mode = { "n", "x", "o" }, desc = "hop improved f" },
            { "F", mode = { "n", "x", "o" }, desc = "hop improved F" },
            { "t", mode = { "n", "x", "o" }, desc = "hop improved t" },
            { "T", mode = { "n", "x", "o" }, desc = "hop improved T" },
            {
                "<leader>hw",
                function()
                    require "hop".hint_words()
                end,
                desc = "hop word"
            },
            {
                "<leader>h2",
                function()
                    require "hop".hint_char2()
                end,
                desc = "hop 2 char hint"
            },
            {
                "<leader>h1",
                function()
                    require "hop".hint_char1()
                end,
                desc = "hop 1 char hint"
            },
            {
                "<leader>h/",
                function()
                    require "hop".hint_patterns()
                end,
                desc = "hop pattern hint"
            }
        },
        config = function()
            local mode = { "n", "x", "o" }
            local hop = require("hop")
            local directions = require("hop.hint").HintDirection

            local echo = vim.api.nvim_echo
            local noop = function()
            end
            vim.keymap.set(mode, "f", function()
                --disable nvim_echo temporarily
                vim.api.nvim_echo = noop
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
            end, { remap = true })
            vim.keymap.set(mode, "F", function()
                vim.api.nvim_echo = noop
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
            end, { remap = true })
            vim.keymap.set(mode, "t", function()
                vim.api.nvim_echo = noop
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
            end, { remap = true })
            vim.keymap.set(mode, "T", function()
                vim.api.nvim_echo = noop
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
            end, { remap = true })

            require("hop").setup()

            if vim.api.nvim_echo == noop then
                vim.api.nvim_echo = echo
            end
        end,
    },
    -- library used by other plugins
    { "nvim-lua/plenary.nvim",       lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true }, -- Glyphs and Icons for neovim

    -- todo comments
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        cmd = { "TodoTrouble", "TodoTelescope" },
        config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
        },
    },
    -- better diagnostics list and others
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        vim.cmd.cprev()
                    end
                end,
                desc = "Previous trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        vim.cmd.cnext()
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
        opts = {
            mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
            -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example: close = {},
            action_keys = {
                close = "q",                  -- close the list
                cancel = "<esc>",             -- cancel the preview and get back to your last window / buffer / cursor
                refresh = "r",                -- manually refresh
                jump = { "<cr>", "<tab>" },   -- jump to the diagnostic or open / close folds
                open_split = { "<c-x>" },     -- open buffer in new split
                open_vsplit = { "<c-v>" },    -- open buffer in new vsplit
                open_tab = { "<c-t>" },       -- open buffer in new tab
                jump_close = { "o" },         -- jump to the diagnostic and close the list
                toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
                toggle_preview = "P",         -- toggle auto_preview
                hover = "K",                  -- opens a small poup with the full multiline message
                preview = "p",                -- preview the diagnostic location
                close_folds = { "zM", "zm" }, -- close all folds
                open_folds = { "zR", "zr" },  -- open all folds
                toggle_fold = { "zA", "za" }, -- toggle fold of current file
                previous = "k",               -- preview item
                next = "j",                   -- next item
            },
            auto_open = false,                -- automatically open the list when you have diagnostics
            auto_close = true,                -- automatically close the list when you have no diagnostics
            -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
            auto_preview = true,
            auto_fold = false, -- automatically fold a file trouble list at creation
            use_diagnostic_signs = true
        },
    },
    -- which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                marks = true,     -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                spelling = {
                    enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = true,    -- adds help for operators like d, y, ...
                    motions = true,      -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true,      -- default bindings on <c-w>
                    nav = true,          -- misc bindings to work with windows
                    z = true,            -- bindings for folds, spelling and others prefixed with z
                    g = true,            -- bindings for prefixed with g
                },
            },
            -- add operators that will trigger motion and text object completion
            -- to enable all native operators, set the preset / operators plugin above
            operators = { gc = "Comments" },
            motions = {
                count = true,
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            local keymaps = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gz"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>b"] = { name = "+buffer/BufferLine" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
                ["<leader>h"] = { name = "+gitsigns/hop" },
                ["<localleader>"] = { name = "<localleader>" },
            }
            wk.register(keymaps)
        end,
    },
    -- add symbols-outline
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
        opts = {
            keymaps = {
                close = { "jk", "q" },
                goto_location = "<Cr>",
                focus_location = "o",
                hover_symbol = "<C-space>",
                toggle_preview = "p",
                rename_symbol = "r",
                code_actions = "a",
                fold = "zf",
                unfold = "zu",
                fold_all = "zC",
                unfold_all = "zO",
                fold_reset = "zR",
            },
        },
    },
}
