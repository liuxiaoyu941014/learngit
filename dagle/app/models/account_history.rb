# == Schema Information
#
# Table name: account_histories
#
#  id               :integer          not null, primary key
#  account_id       :integer
#  amount           :decimal(8, 2)
#  relation_account :integer
#  relation_type    :integer
#  relation_date    :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class AccountHistory < ApplicationRecord
  audited
  belongs_to :account
end
