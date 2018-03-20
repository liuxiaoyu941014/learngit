# Paperclip::Attachment.default_options.update((Settings.paperclip['options'] || {}).deep_symbolize_keys)
Paperclip.interpolates :year do |attachment, style|
  attachment.instance.created_at.year
end

Paperclip.interpolates :month do |attachment, style|
  attachment.instance.created_at.month
end

Paperclip.interpolates :day do |attachment, style|
  attachment.instance.created_at.day
end