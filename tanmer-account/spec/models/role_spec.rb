require 'rails_helper'

RSpec.describe Role, type: :model do
  context "associations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should have_and_belong_to_many(:users).join_table('roles_users') }
    it { should have_and_belong_to_many(:permissions).join_table('roles_permissions') }
    it { should accept_nested_attributes_for :permissions }
  end

  it "ADMIN_ID should be 1" do
    expect(Role::ADMIN_ID).to eq 1
  end

  context "admin role" do
    subject { Role.create(id: 1, name: '管理员') }
    it { expect(subject.admin?).to be true }
    it { expect(subject.can_destroy?).to be false }
    it { expect(subject.can_update?).to be false }
  end

  context "normal role" do
    subject { Role.create(name: '用户') }
    it { expect(subject.admin?).to be false }
    it { expect(subject.can_destroy?).to be true }
    it { expect(subject.can_update?).to be true }
  end
end
