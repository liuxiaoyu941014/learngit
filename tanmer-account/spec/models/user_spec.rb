require 'rails_helper'

RSpec.describe User, type: :model do
  context "assocations" do
    it { should have_many(:api_keys).dependent(:destroy) }
    it { should have_many(:omniauth_users).dependent(:destroy) }
    it { should have_and_belong_to_many(:roles).join_table('roles_users') }
    it { should have_many(:permissions).through(:roles) }
    it { should validate_presence_of :email }
  end

  context "methods" do
    it { should respond_to :can? }
    it { should respond_to :cannot? }
  end

  pending 'check from_omniauth'

  it { expect(subject.ability).to be_a Ability }

  context "roles" do
    subject { User.create!(email: 'user@example.com', password: 'a password') }
    let(:role1) { Role.create!(name: 'Role 1') }
    let(:role2) { Role.create!(name: 'Role 2') }
    let(:role3) { Role.create!(name: 'Role 3') }
    before do
      subject.roles = [role1, role2]
    end
    it "add role" do
      expect(subject.roles.exists?(role3.id)).to be false
      subject.add_role(role3)
      expect(subject.roles.exists?(role3.id)).to be true
    end

    it "no duplicate role added" do
      subject.add_role(role3)
      subject.add_role(role3)
      subject.add_role(role3)
      expect(subject.roles.count).to eq 3
    end

    it 'remove role' do
      expect(subject.roles.exists?(role1.id)).to be true
      subject.remove_role(role1)
      expect(subject.roles.exists?(role1.id)).to be false
    end
  end

  context "protect last administrator" do
    let(:user1) { User.create!(email: 'user1@example.com', password: 'a password') }
    let(:user2) { User.create!(email: 'user2@example.com', password: 'a password') }
    let(:role_admin) { Role.create!(id: Role::ADMIN_ID, name: '管理员') }
    let(:role_normal) { Role.create!(name: '员工') }
    before do
      user1.add_role role_admin
      user2.add_role role_admin
      user2.add_role role_normal
    end
    it 'can not destroy last admin' do
      expect(user2.destroy).not_to be false
      expect(user1.destroy).to be false
      expect(user1.errors[:base]).to eq ['最后一个管理员不能被删除']
    end
    it 'can not remove last admin role' do
      expect(user1.remove_role(role_admin)).not_to be false
      expect(user2.remove_role(role_admin)).to be false
    end
  end

end
