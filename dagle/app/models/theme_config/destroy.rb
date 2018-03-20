class ThemeConfig
  Destroy =
    lambda do |theme_config_or_id, user: nil|
      theme_config = theme_config_or_id.is_a?(ThemeConfig) ? theme_config_or_id : ThemeConfig.find(theme_config_or_id)
      [theme_config.destroy, theme_config]
    end
end
