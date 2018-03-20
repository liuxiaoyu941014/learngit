require 'rails_helper'

RSpec.describe Material::Create, type: :model do
  it do
    record = create(:material)
    true_of_false = Material::Destroy.(record)
    expect(true_of_false).to be_a(Material)
    expect(Material.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
