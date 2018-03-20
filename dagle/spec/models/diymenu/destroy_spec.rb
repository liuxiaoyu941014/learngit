require 'rails_helper'

RSpec.describe Diymenu::Create, type: :model do
  it do
    record = create(:diymenu)
    true_of_false = Diymenu::Destroy.(record)
    expect(true_of_false).to be_a(Diymenu)
    expect(Diymenu.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
