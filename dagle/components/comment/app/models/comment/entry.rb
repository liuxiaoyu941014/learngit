module Comment
  class Entry < ApplicationRecord
    store_accessor :features, :offer, :images, :files
    belongs_to :resource, polymorphic: true, counter_cache: :comments_count
    belongs_to :user, optional: true
    belongs_to :parent, class_name: 'Comment::Entry'
    has_many :children, class_name: 'Comment::Entry', foreign_key: :parent_id, dependent: :destroy
    has_many :image_item_relations, as: :relation, dependent: :destroy
    has_many :image_items, :through => :image_item_relations
    has_many :attachment_relations, as: :relation, dependent: :destroy
    has_many :attachments, :through => :attachment_relations
    has_many_likes
    has_many :complaints, as: :source, dependent: :destroy

    validates_presence_of :content
    validate :check_parent_id

    scope :undisplayable, -> { where(is_complainted: true) }
    scope :displayable, -> { where(is_complainted: false) }

    def check_parent_id
      errors.add(:parent_id, "parent_id don't exist") if parent && !resource.comments.exists?(parent_id)
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
end
