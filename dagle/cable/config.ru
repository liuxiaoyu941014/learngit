require_relative '../config/environment'
# binding.pry

# TODO: 这个文件无法用，解决不了用户验证问题
exit 1

Rails.application.eager_load!

use Rails::Rack::Logger
use ActionDispatch::Cookies
use ActionDispatch::Session::CookieStore
# use Rack::Session::Cookie
use Warden::Manager, Devise.warden_config do |config|
    binding.pry
end

# Warden::Manager.methods.grep(/^(before|prepend)_/).each do |m|
#     Warden::Manager.send(m) do |w|
#         puts m
#         # binding.pry
#     end
# end

# binding.pry

run ActionCable.server