-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapLeader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      i = {
        ["<C-g>"] = { function() vim.lsp.buf.signature_help() end },
        ["jk"] = { "<Esc>", desc = "Normal mode" },
        ["jj"] = { "<Esc>", desc = "Normal mode" },
      },
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        ["<Leader>t1"] = { function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
        ["<Leader>t2"] = { function() require("neotest").run.run(vim.fn.expand "%") end, desc = "[t]est run [f]ile" },
        ["<Leader>t3"] = { function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
        ["<Leader>t4"] = {
          function() require("neotest").output.open { enter = true, auto_close = true } end,
          desc = "[t]est [o]utput",
        },
        ["<Leader>t5"] = { function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
        ["<Leader>Tl"] = { function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
        ["<Leader>TO"] = { function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
        ["<Leader>Tt"] = { function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
        ["ö"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["Ö"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        -- ["ö"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
        -- ["Ö"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" },
        ["<Leader>W"] = { "<cmd>noa w<cr>", desc = "Save without formatting" },
        ["<Leader>å"] = { "<cmd>Coverage<cr>", desc = "Enable coverage" },
        ["<Leader>lm"] = { "<cmd>GoFillStruct<cr>", desc = "Fill Go struct" },
        ["<Leader>le"] = { "<cmd>GoIfErr<cr>", desc = "if err != nil" },
        ["<Leader>lg"] = { "<cmd>GoGenReturn<cr>", desc = "Go assign output from func" },
        ["å"] = { "<cmd>GoAlt!<cr>", desc = "Alternate file" },
        ["Å"] = { "<cmd>GoAltV!<cr>", desc = "Alternate file vertical split" },
        ["ä"] = { "i<cr><Esc>", desc = "Insert linebreak" },
        ["-"] = { "/", desc = "Search forward" },
        ["_"] = { "?", desc = "Search backward" },
        ["Z"] = { "zz", desc = "Center view" },
        ["ZZ"] = { "zt", desc = "Top view" },
        ["<Leader>,"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" },
        ["<Leader>e"] = { "<cmd>Neotree toggle position=float<cr>", desc = "Toggle Explorer" },
        ["§"] = { "<cmd>Neotree toggle position=float<cr>", desc = "Toggle Explorer" },
        ["<Leader>lk"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
        ["<Leader>lj"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
        ["<C-j>"] = { function() vim.lsp.codelens.run() end, desc = "LSP CodeLens run" },
        ["<C-k>"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
        ["<C-b>"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.vsplit()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end,
          desc = "Vertical split buffer from tabline",
        },
        ["<Leader>fs"] = {
          function()
            local aerial_avail, _ = pcall(require, "aerial")
            if aerial_avail then
              require("telescope").extensions.aerial.aerial()
            else
              require("telescope.builtin").lsp_document_symbols()
            end
          end,
          desc = "Search symbols",
        },
        ["°"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },
      },
    },
  },
}
