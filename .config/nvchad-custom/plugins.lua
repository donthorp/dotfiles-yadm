local plugins = {

{
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",

        -- web dev 
        "html",
        "css",
        "javascript",
        "json",

        -- general
        "awk",
        "bash",
        "clojure",
        "dockerfile",
        "jq",
        "markdown",
        "regex",
        "sql",
        "terraform",
        "yaml",
      },
    },
  },


}

return plugins
