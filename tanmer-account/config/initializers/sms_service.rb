require_relative './redis'

if Rails.env.production?
  SmsService.adapter = SmsService::Adapters::YunPian
  SmsService::Adapters::YunPian.api_key = ENV['SMS_YUN_PIAN_V1_KEY']
else
  SmsService.adapter = SmsService::Adapters::Develop # 开发模式，模拟发送
end

SmsService.redis = Redis.current