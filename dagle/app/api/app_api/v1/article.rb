module AppAPI::V1
  class Article < AppAPI::BaseAPI
    helpers AppAPI::SharedParams
    resources :articles do

      desc "发布文章" do
        success AppAPI::Entities::Article
      end
      params do
        requires :description, type: String, desc: '文章内容'
        requires :title, type: String, desc: '文章标题'
        optional :room_id, type: Integer, desc: '文章来源'
        optional :image_item_ids, type: Array[Integer], coerce_with: ->(val) { val.split(/,|，/).map(&:to_i) }, desc: '图片IDs'
        optional :product_ids, type: Array[Integer], coerce_with: ->(val) { val.split(/,|，/).map(&:to_i) }, desc: '产品ID列表'
        optional :tag_list, type: String, desc: '文章标签, 多个文章用逗号隔开'
      end
      post do
        authenticate!
        article = ::Article.new(title: params[:title], description: params[:description])
        article.author = current_user.id
        if Settings.project.imolin?
          article.community_id = current_user.current_community.id
        end
        article.source = ::Chat::Room.find(params[:room_id]) if params[:room_id]
        article.image_item_ids = params[:image_item_ids] if params[:image_item_ids]
        article.product_ids = params[:product_ids] if params[:product_ids]
        article.tag_list = params[:tag_list]  if params[:tag_list]
        error! article.errors unless article.save
        present article, with: AppAPI::Entities::Article, includes: ['description']
      end

      desc "文章列表" do
        success AppAPI::Entities::ArticleSimple
      end
      params do
        if Settings.project.imolin?
          # optional :community_id, type: Integer, desc: '小区下的所有文章列表'
          optional :source_name, type: String, desc: '根据小区来源名称搜索'
        end
        optional :includes, type: String, values: ['description', 'comments'], desc: '选择description后会返回文章类容'
        optional :type, type: String, values: ['owner', 'recommend'], desc: '选择owner后会返回我的文章类容'
        optional :source_id, type: Integer, desc: '文章来源ID'
        optional :source_type, type: String, values: ['room'], desc: '文章来源类型'
        all_or_none_of :source_id, :source_type
        optional :tag_list, type: String, desc: '文章标签,用逗号隔开'
        use :pagination
        use :sort, fields: [:id, :created_at, :updated_at] unless Settings.project.imolin?
      end
      get do
        authenticate!
        articles =
            case params[:type]
            when 'owner' then current_user.articles
            when 'recommend' then ::Article.where(is_flatform_recommend: true)
            else
              ::Article.all.displayable
            end
        if params[:source_type]
          articles =
            case params[:source_type]
            when 'room' then articles.where(source: ::Chat::Room.find(params[:source_id]))
            else
              []
            end
        end
        if Settings.project.imolin?
          error! '请先设置您的小区信息!' unless current_user.current_community
          articles = articles.where(community_id: [current_user.current_community.id, nil]).order("article_type asc, is_top desc, created_at desc")
          if params[:source_name]
            rooms = current_user.current_community.chat_rooms.where("name like ?", "%#{params[:source_name]}%")
            articles = articles.where(source: rooms)
          end
        end
        if params[:tag_list]
          tag_list = params[:tag_list].split(/,/)
          articles = articles.tagged_with(tag_list, :any => true)
        end
        # 筛选掉有效期时间外的Article
        now = Time.now
        articles = articles.where('article_type != ? or article_type is null', 2).where('valid_time_begin is null or valid_time_begin <= ? and valid_time_end >= ?', now, now)
        articles = paginate_collection(sort_collection(articles), params)
        wrap_collection articles, AppAPI::Entities::Article, type: :list, includes: [params[:includes]], user_id: current_user.id
      end

      desc '查看文章详细' do
        success AppAPI::Entities::Article
      end
      params do
        requires :id, type: Integer, desc: '文章ID'
      end
      get ':id' do
        authenticate!
        present ::Article.find(params[:id]), with: AppAPI::Entities::Article, includes: ['description'], user_id: current_user.id
      end

      desc '删除文章' do
        success AppAPI::Entities::Article
      end
      params do
        requires :id, type: Integer, desc: '文章ID'
      end
      delete ':id' do
        authenticate!
        article = ::Article.find(params[:id])
        if Settings.project.sxhop?
          if (article.user.id == current_user.id && article.created_at < 5.minutes.ago) ||
            current_user.permission?(:manage_article)
            article.destroy
            present article, with: AppAPI::Entities::Article
          else
            error! '没有删除权限'
          end
        else
          if article.user.id == current_user.id
            article.destroy
            present article, with: AppAPI::Entities::Article
          else
            error! '没有删除权限'
          end
        end
      end

      desc '文章评论' do
        success AppAPI::Entities::Comment
      end
      params do
        requires :id, type: Integer, desc: '文章ID'
        requires :content, type: String, desc: '评论或者回复内容'
        optional :parent_id, type: Integer, desc: '如果填写，parent_id就是回复的某条评论的ID'
      end
      post ':id/comment' do
        authenticate!
        article = ::Article.find_by(id: params[:id])
        error! '该文章不存在' unless article

        comment_attributes = {}
        comment_attributes[:content]  = params[:content]
        comment_attributes[:parent]   = ::Comment::Entry.where(id: params[:parent_id]).first unless params[:parent_id].blank?
        comment_attributes[:user]     = current_user

        comment = article.comments.new(comment_attributes)
        if comment.save
          present comment, with: AppAPI::Entities::Comment
        else
          error! comment.errors
        end
      end

      desc '活动报名' do
        # success AppAPI::Entities::Comment
      end
      params do
        requires :id, type: Integer, desc: '文章ID'
      end
      post ':id/apply' do
        authenticate!
        article = ::Article.find_by(id: params[:id])
        error! '该文章不存在' unless article

        article.users << current_user
        if article.save
          present status: 'success'
        else
          error! article.errors
        end
      end

      desc '活动点赞' do
        # success AppAPI::Entities::Comment
      end
      params do
        requires :id, type: Integer, desc: '文章ID'
      end
      post ':id/like' do
        authenticate!
        article = ::Article.find_by(id: params[:id])
        error! '该文章不存在' unless article

        article.likes.tag_by! current_user # 点赞
        if article.save
          present status: 'success'
        else
          error! article.errors
        end
      end

      desc '取消点赞活动'
      params do
        requires :id, type: Integer, desc: "文章ID"
      end
      delete ':id/like' do
        authenticate!
        article = ::Article.find_by(id: params[:id])
        error! '该文章不存在' unless article
        if article.likes.tagged_by? current_user
          article.likes.untag_by! current_user
        end
        present message: '取消点赞成功!'
      end

      desc '是否点赞了此活动'
      params do
        requires :id, type: Integer, desc: "文章ID"
      end
      post ':id/is_liked' do
        authenticate!
        article = ::Article.find(params[:id])
        is_liked = article.likes.tagged_by? current_user
        present is_liked: is_liked
      end

    end # end of resources
  end
end
