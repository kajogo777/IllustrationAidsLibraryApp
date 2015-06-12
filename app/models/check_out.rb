class CheckOut < ActiveRecord::Base

	validates :check_out_date , presence: true
	validates :deadline_date , presence: true
	validates :item_id , presence: true
	validates :person_id , presence: true

	belongs_to :item
	belongs_to :person
	
end
