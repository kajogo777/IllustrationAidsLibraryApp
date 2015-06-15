class Service < ActiveRecord::Base

	validates :name, presence: true
	validate :check_serv

	has_and_belongs_to_many :people

	def serv_name
		self.name + " " + self.sub_name
	end

	private

	def check_serv

		b = Service.where(name: self.name).blank?
		unless(self.sub_name == nil)
			b |= Service.where(sub_name: self.sub_name).blank?
		end

		if b
			true
		else
			errors.add('Service','already exist.')
			false
		end

	end
	
end
