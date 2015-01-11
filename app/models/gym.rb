class Gym < ActiveRecord::Base
	has_many :pictures
	has_many :pricings
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

	def as_json(options={})
	    options.merge!(:methods => [:id_, :facilities_available])
	    super(options)
	end
end
