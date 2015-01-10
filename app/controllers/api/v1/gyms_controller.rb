module Api
  module V1
    class GymsController < ApplicationController
      # before_filter :set_api_headers
      before_filter :restrict_access
      skip_before_filter :verify_authenticity_token
      skip_before_filter :authenticate_user!
      respond_to :json

      def explore
        @lan = params[:lang]
        @lon = params[:long]
        @gyms = Gym.nearest_gyms_mobile(@lan, @lon)
        render :json => @gyms.to_json(:include => [:pricings, :pictures, :agency]), :status => 202
      end
      
    end
  end
end