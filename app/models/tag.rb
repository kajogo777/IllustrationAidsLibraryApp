class Tag < ActiveRecord::Base

	validates :name, uniqueness: true, presence: true
	

	has_and_belongs_to_many :items


	def self.counts
  		self.select("name, count(items_tags.tag_id) as count").joins(:items_tags).group("items_tags.tag_id")
	end
	
end
