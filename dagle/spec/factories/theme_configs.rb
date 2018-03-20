# == Schema Information
#
# Table name: theme_configs
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  theme_id   :integer
#  config     :text
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :theme_config do
    config "MyText"
  end
end
