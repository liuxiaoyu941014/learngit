require_relative 'sidekiq'
RestClient.log = Logger.new(STDOUT) unless Rails.env.production?
Sms.setup do |s|
  s.redis = Redis.current
  s.service =
    lambda do |token_body|
      if (Rails.env.staging? || Rails.env.production?) && token_body.mobile_phone != Settings.test_account.mobile_phone
        Sms::Services::YunPianService.send_text(token_body.mobile_phone, token_body.message)
      else
        Sms::Services::YunPianService::SendResponse.new('code' => 0)
      end
    end
end
Sms::Services::YunPianService.api_key = Settings.sms.yun_pian_v1.api_key