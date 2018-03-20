class Notification < ApplicationRecord
  audited

  belongs_to :actor, class_name: 'User'
  belongs_to :user, class_name: 'User'
  belongs_to :target, polymorphic: true, optional: true
  belongs_to :second_target, polymorphic: true, optional: true
  # belongs_to :third_target, polymorphic: true, optional: true

  scope :unread, -> { where(read_at: nil) }

  def read?
    self.read_at.present?
  end

  def actor_name
    return '' if self.actor.blank?
    self.actor.nickname
  end

  def actor_avatar_url
    self.actor.display_headshot
  end

  #  有actor_id时
  # <img src="<%= notice.actor_avatar_url%>" alt="" class="img-circle" width="80px">
  # <a href="#"><%= notice.actor_name%></a>
  # <p>对您的<%= notice.notify_type %> <a href="<%=notice.target_url%>"><%= notice.target.send(notice.target_name) %></a> <%= notice.content%></p>
  # <a href="<%=notice.second_target_url%>"><%= notice.second_target.send(notice.second_target_name) %></a>
  # 您的评论'aaa'有了新回复:'bbbbb'
  # 无actor_id时
  # <p class="orderDescription">你的<%= notice.notify_type%>
  #   <a href="<%=notice.target_url %>"><%= notice.target.send(notice.target_name)%></a>
  #   <%= notice.content%>
  # </p>
  # #####您的订单状态更新了
  def self.notice(user_id, actor_id, type, content, target, target_name, target_url=nil, second_target=nil, second_target_name=nil, second_target_url=nil)
    record = create({
      user_id: user_id,
      actor_id: actor_id,
      notify_type: type,
      content: content,
      target: target,
      target_name: target_name,
      target_url: target_url,
      second_target: second_target,
      second_target_name: second_target_name,
      second_target_url: second_target_url
    })
    UserChannel.broadcast_to User.find(user_id), message: record.to_json, type: 'notification-message' if user_id.present?
  end

  def self.read!(notification_ids)
    where(id: notification_ids).update_all(read_at: Time.now)
  end
end
