class ThemeConfig
  Update =
    lambda do |theme_config_or_id, attributes, user: nil|
      theme_config = theme_config_or_id.is_a?(ThemeConfig) ? theme_config_or_id : ThemeConfig.find(theme_config_or_id)
      theme_config.assign_attributes attributes
      [theme_config.save, theme_config]
    end
end
