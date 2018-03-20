module Tracker
  class Options
    attr_accessor :user_id, :resource, :payload, :controller
    attr_reader :origin_options

    def initialize(origin_options, controller)
      @origin_options = origin_options.freeze
      @controller = controller
    end

    def user_id
      get_value(:user_id, Proc.new{ defined?(current_user) && current_user && current_user.id })
    end

    def resource
      get_value(:resource)
    end

    def payload
      get_value(:payload)
    end

    private
    def get_value(key, default=nil)
      value = origin_options.fetch(key, default)
      case value
      when Symbol
        controller.send(value)
      when Proc
        controller.instance_exec(&value)
      else
        value
      end
    end
  end
end
