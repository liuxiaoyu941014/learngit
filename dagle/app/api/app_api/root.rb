class AppAPI::Root < Grape::API
  helpers AppAPI::Helpers
  rescue_from ActiveRecord::RecordNotFound, ->() { error!({error: 'Record not found'}, 404) }
  include AppAPI::V1
  add_swagger_documentation \
    info: {
      title: "TMF API",
      # description: "",
      # contact_name: "Xiaohui",
      # contact_email: "xiaohui@tanmer.com",
    }
end
