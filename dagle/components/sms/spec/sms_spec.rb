RSpec.describe Sms do

  before do
    Sms.redis = Redis.current
    Sms.service = ->(v) {}
  end

  it { is_expected.to respond_to(:setup) }
  it { is_expected.to respond_to(:redis, :redis=) }
  it { is_expected.to respond_to(:key_prefix, :key_prefix=) }
  it { is_expected.to respond_to(:service, :service=) }
  it { is_expected.to respond_to(:mobiles) }
  it { is_expected.to respond_to(:cleanup!) }

  it 'setup' do
    Sms.setup do |s|
      s.redis = 123
      s.key_prefix = 'abc'
      s.service = '(block)'
    end
    expect(Sms.redis).to eq(123)
    expect(Sms.key_prefix).to eq('abc')
    expect(Sms.service).to eq('(block)')
  end

  it 'cleanup!' do
    Sms.cleanup!
    expect(Sms.mobiles.size).to eq(0)

    t = Sms::Token.new('139123456789')
    t.create code: '1234', message: 'test'
    t.post!
    expect(Sms.mobiles.size).to eq(1)

    Sms.cleanup!
    expect(Sms.mobiles.size).to eq(0)
  end
end
