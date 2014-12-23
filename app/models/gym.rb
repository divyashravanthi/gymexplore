class Gym < ActiveRecord::Base
	has_many :pictures
	has_many :pricings
	belongs_to :agency

	extend FriendlyId
	friendly_id :name, use: [:slugged, :finders]

	def should_generate_new_friendly_id?
    	new_record? || slug.blank?
  	end
end
