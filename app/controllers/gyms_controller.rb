class GymsController < ApplicationController

	before_filter :authenticate_agency!, :only => [:new, :create, :edit, :update]
	skip_before_filter :verify_authenticity_token, :only => [:get_gyms]

	def explore
		@lat = params[:form_lat]
		@lon = params[:form_lon]
		@locality = params[:gym_search][:locality]
		@gyms = Gym.where(:lang => (@lat.to_f-0.015)..(@lat.to_f+0.015), :long => (@lon.to_f-0.015)..(@lon.to_f+0.015), :verified => true)
		flash[:notice] = "Found #{@gyms.count} gyms. Zoom in to explore"
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
		gym.agency_id = current_agency.id
		if gym.save
			if params[:gym][:images].count > 0
				params[:gym][:images].each do |img|
					gym.pictures.create(:image => img)
				end
			end
			params[:duration].each_with_index do |value, index|
				gym.pricings.create(:duration => params[:duration][index], :price => params[:price][index])
			end
			redirect_to new_gym_path, :notice => "Your gym listing has been submitted for approval."
		else
			redirect_to new_gym_path, :notice => "Something Went Wrong."
		end
	end

	def get_gyms
		@lat = params[:lan]
		@lon = params[:lon]
		@gyms = Gym.where(:lang => (@lat.to_f-0.015)..(@lat.to_f+0.015), :long => (@lon.to_f-0.015)..(@lon.to_f+0.015), :verified => true)
		render :json => @gyms.to_json(:include => {:pictures => {:methods => [:url_json]}})
	end

	def show
		@gym = Gym.find(params[:id])
		@lat = @gym.lang
		@lon = @gym.long
	end

	def edit
		@gym = Gym.find(params[:id])
		@lat = @gym.lang
		@lon = @gym.long
	end

	def update
		gym = Gym.find(params[:id])
		gym.name = params[:name]
		gym.description = params[:description]
		gym.lang = params[:latitude]
		gym.long = params[:longitude]
		gym.address = params[:address]
		gym.facility = params[:other_facilities]
		if gym.save
			if params[:gym][:images].count > 0
				gym.pictures.destroy_all
				params[:gym][:images].each do |img|
					gym.pictures.create(:image => img)
				end
			end
			if params[:duration].count > 0
				gym.pricings.destroy_all
				params[:duration].each_with_index do |value, index|
					gym.pricings.create(:duration => params[:duration][index], :price => params[:price][index])
				end
			end
			redirect_to new_gym_path, :notice => "Successfully Updated."
		else
			redirect_to new_gym_path, :notice => "Something Went Wrong."
		end
	end

	def contact
		AgencyMailer.send_message(params[:name], params[:email], params[:message], params[:gym]).deliver
	end
end
