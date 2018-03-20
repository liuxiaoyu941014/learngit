class ThemeConfig
  Create =
    lambda do |attributes, user: nil|
      theme_config = ThemeConfig.new(attributes)
      [theme_config.save, theme_config]
    end
end
