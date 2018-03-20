# == Schema Information
#
# Table name: cms_channels
#
#  id          :integer          not null, primary key
#  site_id     :integer          not null
#  parent_id   :integer
#  title       :string           not null
#  short_title :string           not null
#  properties  :string
#  tmp_index   :string           not null
#  tmp_detail  :string           not null
#  keywords    :string
#  description :string
#  image_path  :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cms::Channel < ApplicationRecord
  audited
  is_impressionable :counter_cache => true
  belongs_to :site, class_name: '::Cms::Site'
  has_many :pages, -> { order(updated_at: :asc) }, dependent: :destroy
  has_many :children, class_name: "Cms::Channel",
                          foreign_key: "parent_id",
                          dependent: :destroy
  belongs_to :parent, class_name: "Cms::Channel"

  validates :title, :short_title, :tmp_index, :tmp_detail, presence: true
  validates_uniqueness_of :short_title, scope: [:site_id]
  validates :short_title, format: { with: /\A[a-zA-Z0-9-]+\z/,
    message: "名称简写只能包括字母数字和横线" }

  before_validation :sanitize_short_title

  def thumb_image_path
    return if image_path.blank?
    self.image_path.sub(/content|original/, 'thumb')
  end

  def original_image_path
    return if image_path.blank?
    self.image_path.sub(/content|thumb/, 'original')
  end

  private

  def sanitize_short_title
    self.short_title = short_title.parameterize unless short_title.nil?
  end
end
