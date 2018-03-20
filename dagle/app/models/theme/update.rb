class Theme
  Update =
    lambda do |theme_or_id, attributes, user: nil|
      theme = theme_or_id.is_a?(Theme) ? theme_or_id : Theme.find(theme_or_id)
      theme.assign_attributes attributes
      [theme.save, theme]
    end
end
