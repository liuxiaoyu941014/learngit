require 'rails_helper'

RSpec.describe ApplicationSource, type: :model do
  context "associations" do
    it { should belong_to(:application).class_name('Doorkeeper::Application') }
    it { should validate_presence_of(:source) }
    it { should validate_uniqueness_of(:source).scoped_to(:application_id) }
  end

  it "self.allow_cors?(app_id, source)" do
    expect(described_class).to respond_to(:allow_cors?)
    app = Doorkeeper::Application.new(name: 'an app', redirect_uri: 'http://localhost')
    app.source_urls = 'http://example.com;http://test.com'
    app.save
    expect(described_class.allow_cors?(app.uid, 'http://example.com')).to be true
    expect(described_class.allow_cors?(app.uid, 'http://other.com')).to be false
  end
end
