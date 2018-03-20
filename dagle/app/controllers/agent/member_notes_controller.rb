class Agent::MemberNotesController < Agent::BaseController
  before_action :set_member
  before_action :set_member_note, only: [:show, :edit, :update, :destroy]

  def index
    authorize MemberNote
    @agent_member_notes = @agent_member.member_notes.order("created_at DESC").page(params[:page])
    @agent_member_note = @agent_member.member_notes.build
    respond_to do |format|
      format.html
      format.json { render json: @agent_member_notes }
    end
  end

  def show
    authorize @agent_member_note
    respond_to do |format|
      format.html
      format.json { render json: @agent_member_note }
    end
  end

  def new
    authorize MemberNote
    @agent_member_note = MemberNote.new(member_note_params)
  end

  def edit
    authorize @agent_member_note
  end

  def create
    @agent_member_note = MemberNote.new(permitted_attributes(MemberNote))
    @agent_member_note.member_id = @agent_member.id
    @agent_member_note.user_id = current_user.id
    authorize @agent_member_note

    respond_to do |format|
      format.html do
        if @agent_member_note.save
          redirect_to agent_member_member_notes_path(@agent_member), notice: '创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @agent_member_note }
    end

  end

  def update
    authorize @agent_member_note
    respond_to do |format|
      format.html do
        if @agent_member_note.update(permitted_attributes(@agent_member_note))
          redirect_to agent_member_note_path(@agent_member_note), notice: 'Member note 更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @agent_member_note }
    end
  end

  def destroy
    authorize @agent_member_note
    @agent_member_note.destroy
    respond_to do |format|
      format.html { redirect_to agent_member_notes_url, notice: 'Member note 删除成功.' }
      format.json { head 200 }
    end

  end

  private
    def set_member
      @agent_member = Member.find(params[:member_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_member_note
      @agent_member_note = MemberNote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_note_params
      params.require(:member_note).permit(:message)
    end
end
