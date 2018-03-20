require 'rest-client'
module Sms
  module Services
    module YunPianService

      HOST = 'http://yunpian.com/v1' unless const_defined? :HOST

      @@api_key = nil
      def self.api_key
        @@api_key
      end

      def self.api_key=(v)
        @@api_key = v
      end

      class SentFailed < StandardError
        attr_reader :response
        def initialize(response)
          super(response.detail || response.msg)
        end
      end

      class SendResponse
        attr_reader :code, :msg, :count, :fee, :sid, :detail
        def initialize(json)
          @code = json['code']
          @msg = json['msg']
          result = json['result'] || {}
          @count = result['count']
          @fee = result['fee']
          @sid = result['sid']
          @detail = json['detail']
          self
        end

        def valid!
          raise SentFailed.new(self) unless code == 0
        end

      end

      class TextPushStatus
        attr_reader :sid, :uid, :user_receive_time, :error_msg, :mobile, :report_status

        def initialize(json)
          @sid = json['sid']
          @uid = json['uid']
          @user_receive_time = Time.parse(json['user_receive_time'])
          @error_msg = json['error_msg']
          @mobile = json['mobile']
          @report_status = json['report_status']
          self
        end

        def succeed?
          report_status == 'SUCCESS'
        end

        def self.from_json(json)
          data = JSON.parse(CGI.unescape(json['sms_status']))
          data.map{ |d| new(d) }
        end
      end

      class ReplyTextPushStatus
        class IllegalData < StandardError; end

        attr_reader :id, :mobile, :reply_time, :text, :extend, :base_extend

        def initialize(json)
          @id = json['id']
          @mobile = json['mobile']
          @reply_time = json['reply_time']
          @text = json['text']
          @extend = json['extend']
          @base_extend = json['base_extend']
          self
        end

        def self.from_json(json)
          data = JSON.parse(CGI.unescape(json['sms_reply']))
          sign = data.delete('_sign')
          sign_data = data.keys.sort.map { |k| data[k] }.push(api_key).join(',')
          # sign_data = data.keys.sort.map { |k| data[k] }.push('0000').join(',')
          fail IllegalData unless sign == Digest::MD5.hexdigest(sign_data)
          new(data)
        end
      end

      module ClassMethods

        def send_text(mobiles, text, extend = nil)
          params = {
            mobile: Array(mobiles).join(','),
            text: text,
            extend: extend
          }
          post('/sms/send.json', params) do |json|
            SendResponse.new(json)
          end
        end

        private

        def post(path, params = {})
          text = RestClient.post("#{HOST}#{path}", params.merge(apikey: api_key))
          yield JSON.parse(text)
        end

      end

      extend ClassMethods

    end
  end
end
