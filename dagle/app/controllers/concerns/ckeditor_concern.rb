module CkeditorConcern
  extend ActiveSupport::Concern

  included do
    alias_method_chain :respond_with_asset, :hack
  end

  def respond_with_asset_with_hack(asset)
    asset.assetable_id = current_user.id
    asset.assetable_type = current_user.class.name
    respond_with_asset_without_hack(asset)
  end

  def ckeditor_pictures_scope(options = { assetable_id: current_user.id, assetable_type: current_user.class.name })
    ckeditor_filebrowser_scope(options)
  end

  def ckeditor_attachment_files_scope(options = { assetable_id: current_user.id, assetable_type: current_user.class.name })
    ckeditor_filebrowser_scope(options)
  end

  def ckeditor_filebrowser_scope(options = {})
    puts options
    { order: [:id, :desc] }.merge(options)
  end

end
