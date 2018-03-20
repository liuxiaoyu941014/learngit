module AppAPI::V1
  class ChatRoom < Grape::API
    helpers AppAPI::SharedParams
    resources :rooms do

      desc '频道列表' do
        success AppAPI::Entities::ChatRoom.collection
      end
      params do
        if Settings.project.imolin?
          requires :community_id, type: Integer, desc: '小区ID'
        end
        use :pagination
      end
      get do
        authenticate!
        rooms = ::Chat::Room.all
        if Settings.project.imolin?
          community = ::Community.find(params[:community_id])
          Settings.default_data.rooms.each do |room_name|
            ::Chat::Room.find_or_create_by(name: room_name, owner: community)
          end
          rooms = community.chat_rooms
        end
        present rooms, with: AppAPI::Entities::ChatRoom
      end

      desc "创建频道" do
        success AppAPI::Entities::ChatRoom
      end
      params do
        requires :name, type: String, desc: '频道名称'
      end
      post do
        authenticate!
        community = current_user.current_community if Settings.project.imolin?
        existed_chat_room = ::Chat::Room.where(name: params[:name])
        existed_chat_room = existed_chat_room.where(owner: community) if Settings.project.imolin?
        if existed_chat_room.blank?
          chat_room = ::Chat::Room.new(name: params[:name])
          chat_room.owner = community if Settings.project.imolin?
          chat_room.created_by = current_user.id
          error! chat_room.errors unless chat_room.save
          present chat_room, with: AppAPI::Entities::ChatRoom
        else
          error! "圈子已经存在"
        end
      end

      desc "获取频道信息" do
        success AppAPI::Entities::ChatRoom
      end
      params do
        requires :id, type: Integer, desc: '频道ID'
        if Settings.project.imolin?
          requires :community_id, type: Integer, desc: '小区ID'
        end
      end
      get ':id' do
        if Settings.project.imolin?
          scope = ::Chat::Room
        else
          scope = ::Community.find(params[:community_id]).rooms
        end
        scope.find(params[:id])
      end

      desc '删除频道' do
        success AppAPI::Entities::ChatRoom
      end
      params do
        requires :id, type: Integer, desc: '频道ID'
      end
      delete ':id' do
        authenticate!
        room = ::Chat::Room.find(params[:id])
        if room.user && room.user.id == current_user.id
          room.destroy
          present room, with: AppAPI::Entities::ChatRoom
        else
          error! '没有删除权限'
        end
      end

    end # end of resources
  end
end
