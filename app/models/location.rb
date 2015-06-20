class Location < ActiveRecord::Base

	validates :loc1, presence: true

	has_many :items

	def get_full_name
		name = "#{loc1} / #{loc2} / #{loc3}"
	end
	
end
