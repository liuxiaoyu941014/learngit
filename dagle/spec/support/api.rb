RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, type: :api
  config.before(:each, type: :api) do |example|
    host! 'api.example.com'
  end
end
