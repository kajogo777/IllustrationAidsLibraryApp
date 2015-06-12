class ItemsTag < ActiveRecord::Base
	belongs_to :item 
	belongs_to :tag

	def self.item_ids_for_tag(tag_name)
  		joins(:tag).where(tags: { name: tag_name }).select(:item_id)
	end
end