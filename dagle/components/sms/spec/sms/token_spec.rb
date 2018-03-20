RSpec.describe Sms::Token do
  before do
    Sms.redis = Redis.current
    Sms.service = ->(v) {}
    Sms.cleanup!
  end
  after do
    Sms.cleanup!
  end
  subject { described_class.new('139123456789') }
  it { is_expected.to respond_to :mobile_phone, :code, :message }
  it { is_expected.to respond_to :create }
  it { is_expected.to respond_to :post! }
  it { is_expected.to respond_to :valid? }
  it { is_expected.to respond_to :exist? }

  let(:data) { { code: '1234', message: 'hello, your code is 1234' } }
  it 'create' do
    subject.create(data)
    expect(subject.code).to eq(data[:code])
    expect(subject.message).to eq(data[:message])
  end

  it 'post! and valid?' do
    subject.create(data)
    subject.post!
    expect(subject.valid?(data[:code])).to eq(true)
  end

  it 'valid? false code' do
    subject.create(data)
    subject.post!
    expect(subject.valid?('xxx')).to eq(false)
  end

  it 'valid? timeout' do
    subject.create(data)
    subject.post! 1
    sleep 1.5
    expect(subject.valid?(data[:code])).to eq(false)
  end

  it 'exist?' do
    subject.create(data)
    subject.post!
    expect(subject.exist?).to eq(true)
  end

  it 'not exist?' do
    expect(subject.exist?).to eq(false)
  end

  it 'valid? not exist mobile_phone' do
    t = Sms::Token.new('13900000000')
    expect(t.valid?('1234')).to eq(false)
  end
end