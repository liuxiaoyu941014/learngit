class Theme
  Destroy =
    lambda do |theme_or_id, user: nil|
      theme = theme_or_id.is_a?(Theme) ? theme_or_id : Theme.find(theme_or_id)
      theme.destroy
    end
end
