class Theme
  Create =
    lambda do |attributes, user: nil|
      theme = Theme.new(attributes)
      [theme.save, theme]
    end
end
