require 'rails_helper'

RSpec.describe Doorkeeper::Application, type: :model do

  context "associations" do
    it { should have_many(:sources).class_name('ApplicationSource').dependent(:destroy) }
    it { should have_many(:permissions).dependent(:destroy).with_foreign_key(:app_id) }
  end

  describe 'about main' do
    it 'MAIN_ID should be 1' do
      expect(described_class::MAIN_ID).to eq(1)
    end
  
    it 'main should be find(1)' do
      described_class.create!(id: described_class::MAIN_ID, name: 'a app', redirect_uri: 'http://localhost')
      expect(described_class.main.id).to eq(described_class::MAIN_ID)
    end
  end
  
  it 'should not destory main' do
    main = described_class.create!(id: described_class::MAIN_ID, name: 'a app', redirect_uri: 'http://localhost')
    expect(main.destroy).to be false
  end

  it 'sources should be auto created' do
    main = described_class.new(id: described_class::MAIN_ID, name: 'a app', redirect_uri: 'http://localhost')
    main.source_urls = 'http://a.com;http://b.com'
    main.save
    expect(main.sources.length).to eq 2
  end
end
