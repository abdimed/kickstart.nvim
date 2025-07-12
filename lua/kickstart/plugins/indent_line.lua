return {
 { -- Add indentation guides even on blank lines
   'lukas-reineke/indent-blankline.nvim',
   main = 'ibl',
   opts = {
     indent = { char = "│" },
     scope = {
       enabled = true,
       show_start = false,
       show_end = false,
     },
   },
   config = function(_, opts)
     -- Change the white scope to purple color
     vim.api.nvim_set_hl(0, "IblScope", { fg = "#cba6f7" })
     
     require("ibl").setup(opts)
   end,
 },
}