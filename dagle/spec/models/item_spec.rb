require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :site }
  it { should have_many :children }
  it { should have_many :parents }
  it { expect(Item.attribute_names).to match_array %w(id type site_id name name_py features created_at updated_at) }
  it { should have_attr_accessor :description }
  it { should validate_presence_of :name }
  it { should validate_presence_of :site }
  it { should validate_uniqueness_of(:name).scoped_to :site_id }
end
