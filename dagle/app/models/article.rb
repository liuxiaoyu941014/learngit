class Article < ApplicationRecord
  audited

  enum article_type: {
    system: 0,      # 系统公告
    community: 1,   # 小区公告
    banner: 2       # 轮播图详细
  }

  has_many :image_item_relations, as: :relation, dependent: :destroy
  has_many :image_items, :through => :image_item_relations
  has_many :article_products, dependent: :destroy
  has_many :products, :through => :article_products
  has_many :article_users, dependent: :destroy
  # 活动参与人员
  has_many :users, :through => :article_users
  has_many :discovers, as: :resource, dependent: :destroy
  has_many_comments
  has_many_likes
  has_many :complaints, as: :source, dependent: :destroy
  belongs_to :user, foreign_key: :author, class_name: 'User'
  belongs_to :community
  belongs_to :source, polymorphic: true
  acts_as_taggable
  after_save do
    discover = self.discovers.find_or_create_by(resource: self)
    discover.save!
  end

  before_destroy do
    if Settings.project.imolin? && self.source_type == "Chat::Room"
      article_relation_messages = self.source.messages.where("text = ?", '{"_type":"article","articleId":' + self.id.to_s + '}')
      article_relation_messages.destroy_all
    end
  end

  scope :undisplayable, -> { where(is_complainted: true) }
  scope :displayable, -> { where(is_complainted: false) }

  def api_created_at
    created_at.to_i
  end

  # 审核举报内容之后显示aritcle
  def restore_display!
    self.update_attributes(is_complainted: false)
  end

  # 审核举报内容之后屏蔽article
  def approved_complaint!
    self.update_attributes(is_complainted: true)
  end

end
