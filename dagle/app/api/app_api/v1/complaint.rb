module AppAPI::V1
  class Complaint < AppAPI::BaseAPI
    resources :complaints do

      desc '投诉'
      params do
        if Settings.project.imolin?
          requires :complaint_type, type: String, values: ['complaint', 'community_feedback'], desc: "投诉类型（投诉，小区反馈）"
        elsif Settings.project.meikemei?
          requires :complaint_type, type: String, values: ['staff_new', 'complaint'], desc: "美容师入驻, 投诉"
        end
        optional :source_type, type: String, values: ['article', 'comment'], desc: "文章，评论"
        optional :source_id, type: Integer, desc: "投诉内容编号"
        requires :reason, type: String, desc: "投诉原因"
      end
      post do
        authenticate!
        if params[:complaint_type] == 'complaint'
          source =
            case params[:source_type]
            when 'article'
              ::Article.find_by(id: params[:source_id])
            when 'comment'
              ::Comment::Entry.find_by(id: params[:source_id])
            else
              error! "资源不正确"
            end
          error! "投诉内容不存在" unless source
        else
          source = nil
        end

        message = if current_user.complaints.where(source: source, complaint_type: params[:complaint_type]).exists?
          "你已经投诉/反馈过了"
        else
          complaint = current_user.complaints.new(source: source, reason: params[:reason], complaint_type: params[:complaint_type])
          if complaint.save
            "投诉/反馈成功"
          else
            complaint.errors.full_messages.join(', ')
          end
        end

        present message: message
      end
    end
  end
end
