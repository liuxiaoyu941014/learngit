# csv support
require 'csv'
class Admin::FinanceBillsController < Admin::BaseController
  before_action :set_finance_bill, only: [:show, :checked, :cashed]

  # GET /admin/finance_bills
  def index
    authorize FinanceBill
    @filter_colums = %w(id)
    @finance_bills = build_query_filter(FinanceBill.all.where(is_entry: false), only: @filter_colums).order("updated_at DESC").page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@finance_bills.to_json, filename: "finance_bills-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@finance_bills.to_xml, filename: "finance_bills-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        finance_bills_all = FinanceBill.all.where(is_entry: false).checked
        format.html { send_data(to_csv(finance_bills_all), filename: "finance_bills-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/finance_bills/1
  def show
    authorize @finance_bill
  end

  def checked
    authorize @finance_bill
    @finance_bill.checked!
    redirect_to :back
  end
  
  def cashed
    authorize @finance_bill
    @finance_bill.cashed!
    redirect_to :back
  end

  # DELETE /admin/finance_bills/1
  def destroy
    authorize @finance_bill
    @finance_bill.destroy
    redirect_to admin_finance_bills_url, notice: "#{FinanceBill.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_finance_bill
      @finance_bill = FinanceBill.find(params[:id])
    end


    def to_csv(objects)
      return [] if objects.nil?
      # make excel using utf8 to open csv file
      head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join()
      CSV.generate(head) do |csv|
        # 获取字段名称
        column_names = [ '商家店铺', '金额', '账单号', '商家账号']
        csv << column_names        
        objects.each do |obj|
          values = []
          values << obj.site.try(:title)
          values << obj.amount.to_f/100
          values << obj.code
          csv << values
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_finance_bill_params
    #       #   params.require(:admin_finance_bill).permit(policy(@admin_finance_bill).permitted_attributes)
    #       # end
end
