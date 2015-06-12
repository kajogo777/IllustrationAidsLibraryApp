class CheckIn < ActiveRecord::Base

	validates :item_id, presence: true
	validates :person_id, presence: true

	belongs_to :item
	belongs_to :person
	
end
