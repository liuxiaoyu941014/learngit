# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nickname               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Create/Update/Destroy" do
    it { expect(described_class::Create).to be_a(Proc) }
    it { expect(described_class::Update).to be_a(Proc) }
    it { expect(described_class::Destroy).to be_a(Proc) }
  end

  it { should have_one :mobile }
  it { should have_one :weixin }
  it { should have_many :audits }
  it { should have_many :image_items }
  it { should have_many :members }

  describe 'attribtues' do
    subject { described_class.new.attributes }
    it { should include('nickname') }
    it { should include('username') }
    it { should include('email') }
    it { should include('created_at') }
    it { should include('updated_at') }
  end

  it { expect(User).to respond_to :find_by_phone_number }
  it 'find by phone_number' do
    flag, user = User::Create.(mobile_phone: '13912345678', nickname: 'xiaohui')
    user2 = User.find_by_phone_number('13912345678')
    expect(user2).to be_a User
    expect(user2.id).to eq user2.id
  end

  it 'is valid with valid attributes' do
    flag, user = User::Create.(mobile_phone: '13912345678', nickname: 'xiaohui')
    expect(flag).to be(true)
    expect(user.nickname).to eq('xiaohui')
    expect(user.mobile.phone_number).to eq('13912345678')
  end

  it 'is invalid without mobile_phone' do
    flag, user = User::Create.(password: 'abc1234')
    expect(flag).to be(false)
    expect(user.errors[:mobile_phone]).not_to be_empty
  end

  it 'is versioned' do
    flag, user = User::Create.(mobile_phone: '13912345678', nickname: 'xiaohui')
    expect(user.audits.size).to eq(1)
    audit = user.audits.last
    expect(audit.action).to eq('create')
    expect(audit.auditable).to eq(user)
    user.nickname = 'wesley'
    user.save
    expect(user.audits.size).to eq(2)
    audit = user.audits.last
    expect(audit.action).to eq('update')
    expect(audit.audited_changes).to eq("nickname" => ['xiaohui', 'wesley'])
  end

end
