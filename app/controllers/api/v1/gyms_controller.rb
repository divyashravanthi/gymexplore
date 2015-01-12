module Api
  module V1
    class GymsController < ApplicationController
      # before_filter :set_api_headers
      before_filter :restrict_access
      skip_before_filter :verify_authenticity_token
      skip_before_filter :authenticate_user!
      respond_to :json

      def explore
        @lan = params[:search_latitude]
        @lon = params[:search_longitude]
        @gyms = Gym.nearest_gyms_mobile(@lan, @lon)
        render :json => @gyms.to_json(:include => [:pricings, :agency]), :status => 202
      end
      
    end
  end
end