return {
  'Saghen/blink.cmp',
  version = '*',
  dependencies = { 'xzbdmw/colorful-menu.nvim', 'rafamadriz/friendly-snippets' },

  config = function()
    local colorful = require 'colorful-menu'
    require 'blink.cmp'.setup {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      cmdline = {
        enabled = true
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
        },
        keyword = { range = "prefix" },
        menu = {
          auto_show = true,
          border = 'single',
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return colorful.blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return colorful.blink_components_highlight(ctx)
                end,
              },
            },
          }
        },
        trigger = {
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },
      },
      enabled = function()
        return not vim.tbl_contains({ 'prompt', 'TelescopePrompt' }, vim.bo.filetype)
      end,
      fuzzy = {
        prebuilt_binaries = {
          download = true,
        }
      },
      keymap = {
        preset = 'default',
      },
      signature = { enabled = true },
    }
  end

}
