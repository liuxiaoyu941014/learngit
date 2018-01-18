class User < ApplicationRecord 
    before_create { generate_token(:auth_token) }
    has_secure_password
    # 就是给每个用户生成一串不重复的随机数
    def generate_token(column)
        begin
          self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
      end
end
