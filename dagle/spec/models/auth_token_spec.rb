require 'rails_helper'

RSpec.describe AuthToken do
  subject { AuthToken }
  it { should respond_to :encode }
  it { should respond_to :decode }

  it "encode/decode" do
    input = { 'user_id' => 1}
    k = AuthToken.encode(input)
    v = AuthToken.decode(k)
    expect(v).to eq(input)
  end
end

