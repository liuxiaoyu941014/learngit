class UnreadMessages
  def initialize(room, current_user)
    @room = room
    @room_id_key = "room-#{@room.id.to_s}"  
    @current_user = current_user
    @redis = Redis.current
  end

  def user_enter_room
    @redis.sadd(@room_id_key, @current_user.id)
    clear_user_unread_message(@current_user.id)
  end

  def user_leave_room
    @redis.srem(@room_id_key, @current_user.id)
  end

  def add_offline_users_unread_message
    all_users =  @room.owner_type == 'Community' ? @room.owner.users.map(&:id) : []
    current_users = @redis.smembers(@room_id_key)
    offline_users = []
    if current_users
      offline_users = all_users.uniq.map(&:to_s) - current_users
    else
      offline_users = all_users
    end
    offline_users.each do |uid|
      add_user_unread_message(uid)
    end
  end

  def add_user_unread_message(user_id)
    user_room_unread_message_key = "user-#{user_id}-room-#{@room.id}"
    user_room_unread_message_count = @redis.get(user_room_unread_message_key) || 0
    @redis.set(user_room_unread_message_key, user_room_unread_message_count.to_i + 1)
    push_unread_message(user_id)
  end

  def push_unread_message(user_id)
    user = User.find_by(id: user_id)
    return unless user
    rooms = @redis.keys("user-#{user_id}-room-*")
    community = user.current_community
    community_rooms = Chat::Room.where(owner: community).map(&:id)
    push_messages = []
    rooms.each do |key|
      room_id = key.split('room-')[1]
      next if !community_rooms.include?(room_id.to_i)
      push_messages.push({id: room_id, count: @redis.get(key)})
    end
    UserChannel.broadcast_to user, message: "#{push_messages.to_json}", type: 'room'
  end

  def clear_user_unread_message(user_id)
    user_room_unread_message_key = "user-#{user_id}-room-#{@room.id}"
    @redis.set(user_room_unread_message_key, 0)
    push_unread_message(user_id)
  end
end