# csv support
require 'csv'
class Admin::ComplaintsController < Admin::BaseController
  before_action :set_complaint, only: [:show, :edit, :update, :destroy]

  # GET /admin/complaints
  def index
    authorize Complaint
    @complaints = Complaint.all
    if params[:relation]
      @complaint = Complaint.find(params[:relation])
      @complaints = @complaint.source.complaints
    end
    if params[:search].present? && params[:search][:complaint_type].present?
      @complaints = @complaints.where(complaint_type: params[:search][:complaint_type])
    end
    @filter_colums = %w(id reason)
    @complaints = build_query_filter(@complaints, only: @filter_colums).order(status: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@complaints.to_json, filename: "complaints-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@complaints.to_xml, filename: "complaints-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@complaints.as_csv(), filename: "complaints-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/complaints/1
  def show
    authorize @complaint
  end

  # GET /admin/complaints/new
  def new
    authorize Complaint
    @complaint = Complaint.new
  end

  # GET /admin/complaints/1/edit
  def edit
    authorize @complaint
  end

  # POST /admin/complaints
  def create
    authorize Complaint
    @complaint = Complaint.new(permitted_attributes(Complaint))

    if @complaint.save
      redirect_to admin_complaint_path(@complaint), notice: "#{Complaint.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/complaints/1
  def update
    authorize @complaint
    if params[:complaint] && params[:complaint][:status] && @complaint.complaint?
      case params[:complaint][:status]
      when 'rejected'
        @complaint.source.restore_display!
      when 'approved'
        @complaint.source.approved_complaint!
      end
    end
    if @complaint.update(permitted_attributes(@complaint).merge(processed_user: current_user))
      redirect_to admin_complaint_path(@complaint), notice: "#{Complaint.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/complaints/1
  def destroy
    authorize @complaint
    @complaint.destroy
    redirect_to admin_complaints_url, notice: "#{Complaint.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_complaint_params
    #       #   params[:admin_complaint]
    #       # end
end
