module Sms
  class Token
    attr_reader :mobile_phone, :code, :message
    def initialize(mobile_phone)
      @mobile_phone = mobile_phone
    end

    def create(code: nil, message: nil)
      @code = code
      @message = message
    end

    def post!(timeout=600)
      Sms.redis.set redis_key, code
      Sms.redis.expire redis_key, timeout
      Sms.service.(self)
    end

    def exist?
      Sms.redis.get(redis_key) != nil
    end

    def valid?(code)
      Sms.redis.get(redis_key) == code.to_s.strip
    end

    def destroy!
      Sms.redis.del redis_key
    end

    private
    def redis_key
      "#{Sms.key_prefix}#{mobile_phone}"
    end
  end
end
