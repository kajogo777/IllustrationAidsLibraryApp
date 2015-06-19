class PeopleService < ActiveRecord::Base
	belongs_to :person 
	belongs_to :service

end