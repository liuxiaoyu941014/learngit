class CultureController < ApplicationController
    def index
        @message=Message.all
        @picture=Picture.all
        # @culture=Culture.all
        # # @culture1=Culture.where("pic2"=>nil,"pic3"=>nil,"pic4"=>nil)
        # @culture2=Culture.limit(5)
        # @culture3=Culture.limit(5).offset(5)
    end
end
