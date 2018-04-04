class TokensController < ApplicationController
  skip_authorization_check
  before_action :set_token, only: [:show, :edit, :update, :destroy]

  def index
    @tokens = current_user.tokens
  end

  def show
  end

  def new
    @token = current_user.tokens.new
  end

  def edit
  end

  def create
    h = token_params
    data = {
      name: h[:name],
      scopes: 'public api'
    }
    data[:expires_in] = h[:expires_at] && (h[:expires_at] - Time.now).ceil
    @token = current_user.tokens.new(data)

    respond_to do |format|
      if @token.save
        format.html { redirect_to token_path(@token), notice: 'Token创建成功.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    h = token_params
    data = {
      name: h[:name],
      scopes: 'public api'
    }
    data[:expires_in] = h[:expires_at] && (h[:expires_at] - @token.created_at).ceil
    respond_to do |format|
      if @token.update(data)
        format.html { redirect_to token_path(@token), notice: 'Token更新成功.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @token.destroy
    respond_to do |format|
      format.html { redirect_to tokens_path, notice: 'Token删除成功.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = current_user.tokens.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def token_params
      h = params.require(:token)
      {
        name: h[:name],
        expires_at: h[:no_expires] ? nil : Time.parse("#{h['expires_at(1i)']}-#{h['expires_at(2i)']}-#{h['expires_at(3i)']} #{h['expires_at(4i)']}:#{h['expires_at(5i)']}")
      }
    end
end
