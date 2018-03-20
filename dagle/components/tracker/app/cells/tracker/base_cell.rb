module Tracker
  class BaseCell < Cell::ViewModel
    self.view_paths = ['app/cells', File.expand_path('../../', __FILE__)]
  end
end
