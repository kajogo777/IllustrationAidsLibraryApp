class Item < ActiveRecord::Base

	mount_uploader :photo , PhotoUploader

	validates :name, format: { with: /[\p{L}]{2,25}/, message: "not valid name" }, presence: true
	validates :condition, inclusion: { in: %w(OK MAINTENANCE LOST), message: "${value} is not a valid condition, conditions are either OK , MAINTENANCE or LOST " }, presence: true
	validates :category_id, presence: true
	validates :location_id, presence: true
	validates :photo, presence: true

	belongs_to :category
	belongs_to :sub_category
	belongs_to :location
	has_one :check_out, dependent: :destroy
	has_one :person ,through: :check_out
	has_many :check_ins
	has_many :people ,through: :check_ins
	has_and_belongs_to_many :tags
	has_many :requests

	def self.for_tag(tag_name)
  		where("id IN (#{ItemsTag.item_ids_for_tag(tag_name).to_sql})")
	end

 
		#	@file_data = file_data if endfile_data.original_filename.split('.').last.downcase == 'png'
end
