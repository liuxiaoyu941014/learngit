# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( test_room.js cable.js )
Rails.application.config.assets.precompile += %w( docs.js docs.css ) # for doc
Rails.application.config.assets.precompile += %w( frontend.js frontend.css) # for frontend
Rails.application.config.assets.precompile += %w( frontend/pingpp.js )
Rails.application.config.assets.precompile += %w( ckeditor/* )

types = %w(*.png *.gif *.jpg *.eot *.woff *.ttf *.svg)
Rails.application.config.assets.precompile += types

NonStupidDigestAssets.whitelist += [/ckeditor.*[\/]/i]
