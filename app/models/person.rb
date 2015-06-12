class Person < ActiveRecord::Base

	validates :nationalid, length: { is: 14 }, uniqueness: true, presence: true
	validates :first_name, format: { with: /[\p{L}]{2,20}/, message: "not valid name" }, presence: true
	validates :middle_name, format: { with: /[\p{L}]{2,20}/, message: "not valid name" }, presence: true
	validates :last_name, format: { with: /[\p{L}]{2,20}/, message: "not valid name" }, presence: true
	validates :phone_number, presence: true
	validates :mobile_number1, format: { with: /(\+\d{1,3}[- ]?)?\d{11}/, message: "not valid MobNumber" }, presence: true
	validates :mobile_number2, format: { with: /(\+\d{1,3}[- ]?)?\d{11}/, message: "not valid MobNumber" }, allow_blank: true
	validates :addressA, presence: true
	validates :addressB, presence: true
	validates :addressC, presence: true
	validates :role_id, presence: true

	validate :valid_national_id

	belongs_to :role
	has_and_belongs_to_many :services
	has_many :check_outs, dependent: :destroy
	has_many :items ,through: :check_outs
	has_many :check_ins
	has_many :requests

	def get_full_address
		adr = "#{addressC} #{addressB} #{addressA}"
		adr = addressD + adr unless addressD == nil
	end

	def get_full_name
		name = "#{first_name} #{middle_name} #{last_name}"
	end

	def get_all_contacts
		contacts = "Home: #{phone_number}\n"
		contacts += "Mobile: #{mobile_number1}"
		contacts += "\nMobile: #{mobile_number2}" unless mobile_number2 == nil || mobile_number2 == ""
		contacts
	end

private

	def get_birth_date

	  nationalid = self.nationalid
      year = (nationalid[0].to_i * 100) + 1700 + nationalid[1,2].to_i
      month = nationalid[3,2].to_i
      day = nationalid[5,2].to_i
      
      begin
      	self.birth_date = Date.new(year, month, day)
      rescue ArgumentError
      	false
      end

    end

    def valid_national_id
    	errors.add("National Id", "is invalid.") unless get_birth_date
    end

end

