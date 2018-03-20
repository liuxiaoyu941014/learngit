class Chat::Room < ApplicationRecord
  audited
  has_many :messages, dependent: :destroy
  belongs_to :owner, polymorphic: true
  belongs_to :user, foreign_key: :created_by, class_name: 'User'
end
