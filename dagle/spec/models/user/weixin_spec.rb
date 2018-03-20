# == Schema Information
#
# Table name: user_weixins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uid        :string
#  name       :string
#  headshot   :string
#  city       :string
#  province   :string
#  country    :string
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User::Weixin, type: :model do
  it 'attributes' do
    expected_attributes = %w(
      id user_id uid name headshot city province country gender
      created_at updated_at
    )
    expect(User::Weixin.attribute_names.sort).to eq(expected_attributes.sort)
  end
  it { should belong_to :user }
  it { should validate_presence_of :uid }
  it { should validate_uniqueness_of :uid }
end
