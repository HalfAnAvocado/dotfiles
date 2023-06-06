local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font 'Iosevka rnepi'
config.font_size = 12
config.color_scheme = 'Srcery (Gogh)'

config.window_padding = { left = 4, right = 4, top = 4, bottom = 4,
}

config.hide_tab_bar_if_only_one_tab = true

config.default_prog = { '/usr/bin/fish' }
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}

return config
