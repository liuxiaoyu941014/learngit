# == Schema Information
#
# Table name: member_catalogs
#
#  id         :integer          not null, primary key
#  key        :string           not null
#  value      :text             default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MemberCatalog < ApplicationRecord
  audited
  validates_presence_of :key
  validates_uniqueness_of :key

  # ['a', 'b'] => {a, b}
  def psql_value
    s = '{'
    s << value.join(',')
    s << '}'
    s
  end
end
