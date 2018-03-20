require 'rails_helper'

RSpec.describe Tracker do
  it { expect(Tracker).to respond_to(:user_model_name) }
  it do
    Tracker.user_model_name = 'User2'
    expect(Tracker.user_model_name).to eq('User2')
  end
end
