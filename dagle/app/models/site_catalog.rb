# == Schema Information
#
# Table name: catalogs
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#  features   :jsonb
#

class SiteCatalog < Catalog
  has_many :sites, foreign_key: :catalog_id

  def full_name
    if parent
      "#{parent.full_name}/#{name}"
    else
      "#{name}"
    end
  end
end
