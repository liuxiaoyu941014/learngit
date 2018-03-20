# == Schema Information
#
# Table name: user_mobiles
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe User::Mobile, type: :model do
  it { should belong_to :user }
  describe do
    let(:user) { create(:user) }
    subject { build(:user_mobile, user: user) }
    it { should validate_presence_of :user }
    it { should validate_uniqueness_of :user }

    it { should validate_presence_of :phone_number }
    it { should validate_uniqueness_of(:phone_number).case_insensitive }
  end
end
