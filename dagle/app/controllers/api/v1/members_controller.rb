class Api::V1::MembersController < Api::BaseController
  before_action :authenticate!
  before_action :set_site, only: [:index, :create]

  def index
    # authorize Member
    members = @site.members
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    members =  members.where("name ~* :key", {key: params['name']}) if params['name'].present?
    members = members.order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      members: member_json(members),
      page_size: page_size,
      current_page: members.current_page,
      total_pages: members.total_pages,
      total_count: members.total_count
    }
  end

  def create
    authorize Member
    member = @site.members.new(permitted_attributes(Member))
    if member.save
      render json: {status: 'ok', member: member_json(member)}
    else
      render json: {status: 'failed', error_message:  member.errors.full_messages.join(', ') }
    end
  end

  private

    def set_site
      @site = Site.where(id: params[:site_id]).first
    end

    def member_json(members)
      members.as_json(
        only: %w(id name mobile_phone user_id)
      )
    end
end
