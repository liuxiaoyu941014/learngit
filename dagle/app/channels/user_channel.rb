class UserChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    Rails.logger.debug '%s - %s' % [current_user, '登录']
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def push_message
    redis = Redis.current
    rooms = redis.keys("user-#{current_user.id}-room-*")
    community = current_user.current_community
    community_rooms = Chat::Room.where(owner: community).map(&:id)
    push_messages = []
    rooms.each do |key|
      room_id = key.split('room-')[1]
      next if !community_rooms.include?(room_id.to_i)
      push_messages.push({id: room_id, count: redis.get(key)})
    end
    UserChannel.broadcast_to current_user, message: "#{push_messages.to_json}", type: 'room'
  end

  def notifications
    notices = Notification.where(user_id: current_user.id).unread.order(created_at: :desc)
    UserChannel.broadcast_to current_user, messages: notices.to_json, type: 'notification-messages'
  end
end
