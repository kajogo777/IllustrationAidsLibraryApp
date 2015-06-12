class Role < ActiveRecord::Base

	validates :name, uniqueness: true, presence: true
	validates :description, presence: true

	has_many :people
	
end
