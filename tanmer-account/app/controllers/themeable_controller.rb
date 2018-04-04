class ThemeableController < ActionController::Base
  abstract!
  before_action :prepend_view_paths

  private

  def prepend_view_paths
    prepend_view_path "app/views/_themes/#{ENV['PROJECT_TEMPLATE_NAME']}" if ENV['PROJECT_TEMPLATE_NAME'].present?
  end
end
