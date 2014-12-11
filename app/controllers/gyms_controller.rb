class GymsController < ApplicationController

	before_filter :authenticate_agency!, :except => [:explore, :get_gyms]
	skip_before_filter :verify_authenticity_token, :only => [:get_gyms]

	def explore
		@lat = params[:form_lat]
		@lon = params[:form_lon]
		@gyms = Gym.where(:lang => (@lat.to_f-1.00)..(@lat.to_f+1.00), :long => (@lon.to_f-1.00)..(@lon.to_f+1.00), :verified => true)
	end

	def new
		@gym = Gym.new
	end

	def create
		gym = Gym.new
		gym.name = params[:name]
		gym.description = params[:description]
		gym.lang = params[:latitude]
		gym.long = params[:longitude]
		gym.address = params[:address]
		gym.facility = [params[:facilities].join(","), params[:other_facilities]].join(",")
		if gym.save
			params[:gym][:images].each do |img|
				gym.pictures.create(:image => img)
			end
			params[:duration].each_with_index do |value, index|
				gym.pricings.create(:duration => params[:duration][index], :price => params[:price][index])
			end
			redirect_to new_gym_path, :notice => "Successfully Added"
		else
			redirect_to new_gym_path, :notice => "Something Went Wrong"
		end
	end

	def get_gyms
		@lat = params[:lan]
		@lon = params[:lon]
		@gyms = Gym.where(:lang => (@lat.to_f-1.00)..(@lat.to_f+1.00), :long => (@lon.to_f-1.00)..(@lon.to_f+1.00), :verified => true)
		render :json => @gyms.to_json(:include => {:pictures => {:methods => [:url_json]}})
	end
end
