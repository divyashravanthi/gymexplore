class GymsController < ApplicationController
	def explore
		@lat = params[:form_lat]
		@lon = params[:form_lon]
	end

	def new
	end
end
