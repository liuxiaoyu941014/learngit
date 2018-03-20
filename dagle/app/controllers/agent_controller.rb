class AgentController < ApplicationController
  layout false
  def index
  end

  def market_page
    @market_page = MarketPage.find(params[:id])
    @site = @market_page.site
    @member = Member.new(site_id: @site.id)
    impressionist(@market_page, "market_page_#{@market_page.id}")
  end

  def member_new
  end

  def member_create
    authorize Member
    @agent_member = Member.new(params[:member])
    @agent_member.features = params[:features].select{|k,v| v.present?} if params[:features]

    respond_to do |format|
      format.html do
        if @agent_member.save
          redirect_to agent_members_path, notice: '添加成功.'
        else
          render :new
        end
      end
      format.json { render json: @agent_member }
    end
  end

end
