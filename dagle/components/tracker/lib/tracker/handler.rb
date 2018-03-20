module Tracker
  class Handler
    attr_reader :options, :controller, :tracker_session, :tracker_visit

    delegate :session, :request, to: :controller
    def initialize(options, controller)
      @options = options
      @controller = controller
    end

    def pre_response
      process_session
      process_visit
    end

    def post_response
      return unless tracker_visit
      tracker_visit.user_id ||= options.user_id
      tracker_visit.resource ||= options.resource
      tracker_visit.payload ||= options.payload
      if tracker_visit.save
        session['tracker.visit.at'] = Time.now.to_i
        session['tracker.visit.url'] = request.original_url
        session['tracker.visit.id'] = tracker_visit.id
        ChangeUserAgentJob.perform_later tracker_visit.id
      end
    end

    private

    def process_session
      @tracker_session = session['tracker.session.id'] &&
        Tracker::Session.find_by(id: session['tracker.session.id']) rescue nil
      unless tracker_session
        @tracker_session = Tracker::Session.create
        session['tracker.session.id'] = tracker_session.id
      end
    end

    def process_visit
      Tracker::Visit.where(id: session['tracker.visit.id']).limit(1).update_all(updated_at: Time.now) if session['tracker.visit.id']
      # return unless tracker_session
      return if session['tracker.visit.url'] == request.original_url

      @tracker_visit = tracker_session.visits.new
      tracker_visit.action = Tracker::Action.find_or_create_by(
        controller_path: controller.controller_path,
        action_name: controller.action_name)
      tracker_visit.url = request.original_url
      tracker_visit.user_agent_data = {'user_agent': request.user_agent}
      tracker_visit.ip_address = request.ip
    end
  end
end
