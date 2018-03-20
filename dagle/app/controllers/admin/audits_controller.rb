class Admin::AuditsController < Admin::BaseController
  def index
    authorize Audit
    conditions = []
    date_range = []
    if params["daterange"].present?
      date_range = params["daterange"].split(' - ').map(&:strip).map(&:to_date)
      conditions.push "Date(created_at) in (?)"
    end
    if params["username"].present? && params["username"] != '/'
      conditions.push "user_id = #{params["username"]}"
    end
    if params["auditable_type"].present?
      conditions.push "auditable_type = '#{params["auditable_type"]}'"
    end
    if params["auditable_id"].present?
      conditions.push "auditable_id = '#{params["auditable_id"]}'"
    end
    
    @admint_audits = Audit.where(conditions.join(' and '), date_range[0]..date_range[-1]).order(created_at: :desc).page(params[:page])
  end

  def statistics
    authorize Audit
    if params[:user_ids].present?
      conditions = []
      @audits = Audit.where(user_id: params[:user_ids].split(','), auditable_type: params[:auditable_type], action: params[:action_name])
      if params["daterange"].present?
        date_range = params["daterange"].split(' - ').map(&:strip).map(&:to_date)
        @audits =  @audits.where("Date(created_at) in (?)", date_range[0]..date_range[1])
      end
      if params[:format] == 'json'
        audits_array = []
        color = ['#348fe2', '#5da5e8', '#1993E4', '#49b6d6', '#6dc5de', '#3a92ab', '#00acac', '#33bdbd', '#008a8a',
                 '#f59c1a', '#f7b048', '#c47d15', '#2d353c', '#b6c2c9', '#727cb6', '#8e96c5', '#5b6392', '#ff5b57']
        @audits.group(:user_id).count.each_pair do |key, value|
          next if key.blank?
          obj = {}
          obj['user_id'] = key
          obj['label'] = User.find_by(id: key).try(:nickname)
          obj['value'] = value
          obj['color'] = color.sample(1).first
          audits_array.push(obj)
        end
        render json: {audits: audits_array}
      end
    end
    
  end
  
end