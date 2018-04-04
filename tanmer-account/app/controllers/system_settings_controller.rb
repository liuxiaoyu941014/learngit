class SystemSettingsController < ApplicationController
  def show
    authorize! :show, 'SystemSettings'
  end
end
