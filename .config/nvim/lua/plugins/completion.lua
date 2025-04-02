return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  lazy = true,
  opts = {
    keymap = { preset = "default" },
    appearance = {
      use_nvim_cmp_as_default = true,
      kind_icons = require("themes").icons.kinds,
    },
    completion = {
      list = {
        max_items = 100,
      },
      menu = {
        scrollbar = false,
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" }, { "label" },
          },
          components = {
            label = {
              width = { fill = false, max = 46 },
              text = function(ctx)
                if ctx.kind == "Snippet" and #ctx.label > 24 then
                  ctx.label = string.sub(ctx.label, 0, 24)
                end
                ctx.label_detail = "  " .. ctx.label_detail
                return ctx.label .. ctx.label_detail
              end,
            },
          }
        },
      },
      documentation = {
        auto_show = true,
        window = {
          min_width = 30,
          scrollbar = false,
          direction_priority = {
            menu_north = { "e", "w", "n" },
            menu_south = { "e", "w", "s" },
          }
        }
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        show_documentation = false,
        winhighlight = "",
      }
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning"
    }
  },
  opts_extend = { "sources.default" }
}
