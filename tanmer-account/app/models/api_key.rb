class ApiKey < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :auth_token
  validates_uniqueness_of :name, scope: :user_id
  validates_uniqueness_of :auth_token
  before_validation :generate_auth_token

  private

  def generate_auth_token
    return if auth_token.present?
    loop do
      self.auth_token = SecureRandom.uuid
      break unless self.class.where(auth_token: auth_token).exists?
    end
  end
end
