# == Schema Information
#
# Table name: user_weixins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uid        :string
#  name       :string
#  headshot   :string
#  city       :string
#  province   :string
#  country    :string
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User::Weixin < ApplicationRecord
  belongs_to :user
  validates :uid, presence: true, uniqueness: true

  enum gender: [:secret, :male, :female]

  ##
  # get weixin_user base infromation
  # @param [Hash] auth is wexin omniauth request
  # @return [Object] return User::Weixin instance
  #
  def self.from_omniauth(auth)
    cond = auth.extra.raw_info.unionid ? \
      where("uid = ? OR unionid = ?", auth.uid, auth.extra.raw_info.unionid) : \
      where(uid: auth.uid)

    wx_user = cond.first || new
    wx_user.uid = auth.uid
    # wx_user.unionid = auth.extra.raw_info.unionid
    wx_user.name = auth.info.nickname
    wx_user.gender = auth.info.sex
    wx_user.province = auth.info.province
    wx_user.city = auth.info.city
    wx_user.country = auth.info.country
    wx_user.headshot = auth.info.headimgurl
    fail Weixin::RegisterError.new(wx_user) unless wx_user.save
    wx_user
  end

  ##
  # bind weixin_user with user
  # @param [String] user is a User instance
  # @param [Hash] auth is wexin omniauth request
  # @return [Object] return User::Weixin record
  #
  def self.connect_user(user, auth)
    weixin_user = from_omniauth(auth)
    weixin_user.user = user
    weixin_user.save
    weixin_user
  end

  def check_access_token
    url = 'https://api.weixin.qq.com/sns/auth?access_token=%s&openid=%s' % [
      access_token,
      uid
    ]
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    return if data['errcode'] == 0
    refresh_access_token!
  end

  def refresh_access_token!
    return if refresh_token.blank?
    url = 'https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%s&grant_type=refresh_token&refresh_token=%s' % [
      Settings.weixin_open_app.app_id,
      refresh_token
    ]
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    if data['openid'] == uid
      self.access_token = data['access_token']
      self.refresh_token = data['refresh_token']
      self.access_token_expired_at = data['expires_in'].seconds.since
    else
      self.access_token = nil
      self.refresh_token = nil
    end
    self.save!
  end

  def sync!
    return if access_token.blank?

    url = 'https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s' % [
      access_token,
      uid
    ]
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    self.name = data['nickname']
    self.gender = data['sex']
    self.city = data['city']
    self.province = data['province']
    self.country = data['country']
    self.headshot = data['headimgurl']
    save!
  end

end
