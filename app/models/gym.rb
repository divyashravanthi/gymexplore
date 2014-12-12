class Gym < ActiveRecord::Base
	has_many :pictures
	has_many :pricings
	belongs_to :agency
end
