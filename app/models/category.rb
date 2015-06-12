class Category < ActiveRecord::Base

	validates :name, format: { with: /[\p{L}]{2,30}/, message: "not valid name" }, presence: true

	has_many :sub_categories, dependent: :destroy
	has_many :items
	accepts_nested_attributes_for :sub_categories,reject_if: :all_blank, allow_destroy: true

end
