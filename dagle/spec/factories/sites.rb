# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :site do
    id 1
    title 'Site 1'
    description 'MyDescription'

    factory :site2 do
      id 2
      title 'Site 2'
      description 'MyDescription2'
    end
  end
end
