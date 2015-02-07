class Gym < ActiveRecord::Base
	has_many :pictures, :dependent => :destroy
	has_many :pricings, :dependent => :destroy
	has_many :reviews, :dependent => :destroy
	belongs_to :agency

	extend FriendlyId
	friendly_id :name, use: [:slugged, :finders]

	def should_generate_new_friendly_id?
    	new_record? || slug.blank?
  	end

  	def self.nearest_gyms(lat, lon)
  		return Gym.where(:lang => (lat.to_f-0.015)..(lat.to_f+0.015), :long => (lon.to_f-0.015)..(lon.to_f+0.015), :verified => true)
  	end

  	def self.nearest_gyms_mobile(lat, lon)
  		return Gym.where(:lang => (lat.to_f-0.01)..(lat.to_f+0.01), :long => (lon.to_f-0.01)..(lon.to_f+0.01), :verified => true)
  	end

  	def id_
	    self.id
	end

	def facilities_available
		self.facility.split(",")
	end

	def get_gender
		if self.gender == 1
			return "Male"
		elsif self.gender == 2
			return "Female"
		else
			return "Male and Female"
		end
	end

	def images_url
		images = Array.new
		self.pictures.each do |p|
			images << p.image.url(:thumb)
		end
		return images
	end

	def gym_description
		self.description
	end

	def gym_longitude
		self.long
	end

	def gym_latitude
		self.lang
	end

	def as_json(options={})
	    options.merge!(:methods => [:id_, :gym_description, :gym_latitude, :gym_longitude, :facilities_available, :images_url])
	    super(options)
	end
end
