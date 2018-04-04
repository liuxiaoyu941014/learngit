require 'rails_helper'

RSpec.describe Permission, type: :model do
  context "associations" do
    it { should belong_to(:app).class_name('Doorkeeper::Application') }
    it { should have_and_belong_to_many(:roles).join_table('roles_permissions') }
    it { should validate_presence_of :name }
    it { should validate_presence_of :group_name }
    it { should validate_presence_of :app }
    it { should validate_presence_of :subject_class }
    it { should validate_presence_of :action }
    it { should validate_uniqueness_of(:action).scoped_to(:app_id, :subject_class) }
  end

  context "methods" do
    subject { Permission.new(name: 'check', group_name: 'role') }
    it { should respond_to :friendly_name }
    it { expect(subject.friendly_name).to eq("#{subject.name}#{subject.group_name}") }
  end
end
