class GymsController < ApplicationController

	# before_filter :authenticate_agency!, :only => [:new, :create, :edit, :update]
	skip_before_filter :verify_authenticity_token, :only => [:get_gyms, :filter, :list]

	def explore
		@lat = params[:form_lat]
		@lon = params[:form_lon]
		@locality = params[:gym_search][:locality]
		@gyms = Gym.nearest_gyms(@lat, @lon)
		@message = "Found #{@gyms.count} gyms. Zoom in to explore"
	end

	def new
		@gym = Gym.new
	end

	def create
		gym = Gym.new
		if current_agency.nil?
			@password = SecureRandom.hex(4)
			@agency = Agency.create(:email => params[:email], :password => @password, :password_confirmation => @password, :name=> params[:name], :mobile => params[:mobile])
		end
		gym.name = params[:name]
		gym.website = params[:website]
		gym.description = params[:description]
		gym.lang = params[:latitude]
		gym.long = params[:longitude]
		gym.male_trainers = params[:male_trainers]
		gym.female_trainers = params[:female_trainers]
		gym.address = params[:address]
		if params[:facilities].present?
			gym.facility = [params[:facilities].join(","), params[:other_facilities]].join(",")
		end
		gym.email = params[:email]
		gym.mobile = params[:mobile]
		gym.registration_fee = params[:fees]
		if current_agency.nil?
			gym.agency_id = @agency.id
		else
			gym.agency_id = current_agency.id
		end
		if gym.save
			if params[:gym].present? && params[:gym][:images].count > 0
				params[:gym][:images].each do |img|
					gym.pictures.create(:image => img)
				end
			end
			params[:duration].each_with_index do |value, index|
				gym.pricings.create(:duration => params[:duration][index], :price => params[:price][index])
			end
			if current_agency.nil?
				AgencyMailer.send_credentials(params[:email], @password).deliver_now
				notice = " Check your email to edit."
			end
			redirect_to new_gym_path, :notice => "Submitted for approval.#{notice}"
		else
			redirect_to new_gym_path, :notice => "Something Went Wrong."
		end
	end

	def get_gyms
		@lat = params[:lan]
		@lon = params[:lon]
		@gyms = Gym.nearest_gyms(@lat, @lon)
		render :json => @gyms.to_json(:include => {:pictures => {:methods => [:url_json]}})
	end

	def show
		@gym = Gym.friendly.find(params[:id])
		@lat = @gym.lang
		@lon = @gym.long
	end

	def edit
		@gym = Gym.friendly.find(params[:id])
		@lat = @gym.lang
		@lon = @gym.long
	end

	def update
		gym = Gym.friendly.find(params[:id])
		gym.name = params[:name]
		gym.website = params[:website]
		gym.description = params[:description]
		gym.lang = params[:latitude]
		gym.long = params[:longitude]
		gym.male_trainers = params[:male_trainers]
		gym.female_trainers = params[:female_trainers]
		gym.address = params[:address]
		gym.email = params[:email]
		gym.mobile = params[:mobile]
		gym.registration_fee = params[:fees]
		gym.facility = params[:other_facilities]
		if gym.save
			if params[:gym].present?
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
			redirect_to edit_gym_path(gym), :notice => "Successfully Updated."
		else
			redirect_to edit_gym_path(gym), :notice => "Something Went Wrong."
		end
	end

	def contact
		@gym = Gym.friendly.find(params[:gym])
		if @gym.featured
			require 'nexmo'
			nexmo = Nexmo::Client.new(key: 'ff382c77', secret: '31a903b3')
			str = "Enquiry about #{@gym.name} from #{params[:name]} (#{params[:email]}). Message: #{params[:message]}"
			nexmo.send_message(from: 'GymExplore', to: @gym.mobile, text: str)
		end
		AgencyMailer.send_message(params[:name], params[:email], params[:message], @gym).deliver_now
	end

	def filter
		@lat = params[:filter_lat]
		@lon = params[:filter_lon]
		@gyms = Gym.nearest_gyms(@lat, @lon)
		@f_gyms = Array.new
		if !params[:facilities].nil?
			@gyms.each do |g|
				flag = 0
				params[:facilities].each do |f|
					if !g.facility.include?(f)
						flag = 0
						break
					else
						flag = 1
					end
				end
				if flag == 1
					@f_gyms << g
				end
			end
		else
			@f_gyms = @gyms
		end
		render :json => @f_gyms.to_json(:include => {:pictures => {:methods => [:url_json]}})
	end

	def list
		@lat = params[:filter_lat]
		@lon = params[:filter_lon]
		@gyms = Gym.nearest_gyms(@lat, @lon)
		@f_gyms = Array.new
		if !params[:facilities].nil?
			@gyms.each do |g|
				flag = 0
				params[:facilities].each do |f|
					if !g.facility.include?(f)
						flag = 0
						break
					else
						flag = 1
					end
				end
				if flag == 1
					@f_gyms << g
				end
			end
		else
			@f_gyms = @gyms
		end
		render :layout => false
	end

	def verify_gym
		gym = Gym.find(params[:gym])
		gym.verified = true
		gym.save
	end
end
