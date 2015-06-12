class Location < ActiveRecord::Base

	validates :loc1, presence: true

	has_many :items
	
end
