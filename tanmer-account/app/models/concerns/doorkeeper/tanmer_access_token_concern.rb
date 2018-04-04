module Doorkeeper
  module TanmerAccessTokenConcern
    extend ActiveSupport::Concern
    
    def expires_at
      expires_in && expires_in.seconds.since(created_at)
    end
  end
end