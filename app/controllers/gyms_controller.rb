class GymsController < ApplicationController

	before_filter :authenticate_agency!, :except => [:explore]

	def explore
		@lat = params[:form_lat]
		@lon = params[:form_lon]
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
end
