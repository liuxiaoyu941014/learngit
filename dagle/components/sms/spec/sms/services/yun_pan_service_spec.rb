RSpec.describe Sms::Services::YunPianService do
  it { should respond_to :send_text }

  describe "send sms" do
    before do
      Sms::Services::YunPianService.api_key = 'myapikey'
      
      response_data = {
        code: 0,
        msg: '',
        result: {},
        fee: 0.1,
        sid: 10000,
        detail: 'abc'
      }
      stub_request(:post, "http://yunpian.com/v1/sms/send.json").
         with(:body => {"apikey"=>"myapikey", "extend"=>nil, "mobile"=>"15328077520", "text"=>"hi, xiaohui"}).
        to_return(body: response_data.to_json, status: 200)

      response_data = {
        code: 1,
        msg: 'error'
      }
      stub_request(:post, "http://yunpian.com/v1/sms/send.json").
         with(:body => {"apikey"=>"myapikey", "extend"=>nil, "mobile"=>"15328077521", "text"=>"hi, wj"}).
        to_return(body: response_data.to_json, status: 200)
    end

    it 'to 15328077520' do
      response = Sms::Services::YunPianService.send_text('15328077520', 'hi, xiaohui')
      expect { response.valid! }.not_to raise_error(Sms::Services::YunPianService::SentFailed)
    end

    it 'to 15328077521' do
      response = Sms::Services::YunPianService.send_text('15328077521', 'hi, wj')
      expect { response.valid! }.to raise_error(Sms::Services::YunPianService::SentFailed)
    end
  end

end
