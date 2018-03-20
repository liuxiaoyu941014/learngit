class Settings < Settingslogic
  fail "启动时必须提供环境变量PROJECT_NAME， 如：PROJECT_NAME=dagle rails s" if ENV['PROJECT_NAME'].blank?
  source "#{Rails.root}/config/settings.#{ENV['PROJECT_NAME']}.yml"
  namespace Rails.env

  def project
    @project ||= ActiveSupport::StringInquirer.new(ENV['PROJECT_NAME'])
  end
end
