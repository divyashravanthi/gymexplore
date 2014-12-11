class GymsController < ApplicationController

	before_filter :authenticate_agency!, :except => [:explore]

	def explore
		@lat = params[:form_lat]
		@lon = params[:form_lon]
	end

	def new
	end
end
