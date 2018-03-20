# csv support
require 'csv'
class Admin::AddressBooksController < Admin::BaseController
  before_action :set_user
  before_action :set_address_book, only: [:show, :edit, :update, :destroy]

  # GET /admin/address_books
  def index
    authorize AddressBook
    @filter_colums = %w(id)
    @address_books = build_query_filter(AddressBook.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@address_books.to_json, filename: "address_books-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@address_books.to_xml, filename: "address_books-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@address_books.as_csv(), filename: "address_books-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/address_books/1
  def show
    authorize @address_book
  end

  # GET /admin/address_books/new
  def new
    authorize AddressBook
    @address_book = AddressBook.new
  end

  # GET /admin/address_books/1/edit
  def edit
    authorize @address_book
  end

  # POST /admin/address_books
  def create
    authorize AddressBook
    @address_book = AddressBook.new(permitted_attributes(AddressBook))

    if @address_book.save
      redirect_to admin_address_book_path(@address_book), notice: "#{AddressBook.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/address_books/1
  def update
    authorize @address_book
    if @address_book.update(permitted_attributes(@address_book))
      redirect_to admin_address_book_path(@address_book), notice: "#{AddressBook.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/address_books/1
  def destroy
    authorize @address_book
    @address_book.destroy
    redirect_to admin_user_address_books_url(@user), notice: "#{AddressBook.model_name.human} 删除成功."
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_address_book
      @address_book = AddressBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_address_book_params
    #       #   params.require(:admin_address_book).permit(policy(@admin_address_book).permitted_attributes)
    #       # end
end
