class AppAPI::BaseAPI < Grape::API
  def self.inherited(klass)
    super(klass)
    klass.send(:include, AppAPI::Actions)
  end
end
