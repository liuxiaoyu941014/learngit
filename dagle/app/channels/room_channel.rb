require 'unread_messages'
class RoomChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    @room = Chat::Room.find(params[:id])
    RoomChannel.broadcast_to @room, message: "#{user[:nickname]}加入房间", type: 'system'
    UnreadMessages.new(@room, current_user).user_enter_room
    stream_for @room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
    RoomChannel.broadcast_to @room, message: "#{user[:nickname]}离开房间", type: 'system'
    # uses_chat_rooms = UsersChatRoom.find_or_create_by(user: current_user, chat_room: @room)
    # uses_chat_rooms.update(last_message_id: @room.messages.last.id)
    UnreadMessages.new(@room, current_user).user_leave_room
  end

  def unsubscribe_from_channel
    unsubscribed
  end

  def say(data)
    Rails.logger.debug '%s say - %s' % [current_user, data]
    @room.messages.create(text: data['message'], user: current_user) if current_user
    RoomChannel.broadcast_to @room, message: data['message'], type: 'message', user: user
    UnreadMessages.new(@room, current_user).add_offline_users_unread_message
  end

  def user
    current_user ? {nickname: current_user.nickname, id: current_user.id, avatar: current_user.display_headshot} : {nickname: '游客'}
  end

end
