# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: ENV['SSO_COOKIE_NAME'], domain: ENV['SSO_COOKIE_DOMAIN'] || :all
