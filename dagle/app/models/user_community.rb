class UserCommunity < ApplicationRecord
  audited
  belongs_to :user
  belongs_to :community
end
