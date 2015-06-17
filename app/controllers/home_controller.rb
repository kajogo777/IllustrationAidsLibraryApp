class HomeController < ApplicationController

	def index
		@tags = Tag.all.map{|x| x.name}
	end

	def hierarchy

		@cathierarchy = Category.all.includes(:items , sub_categories: :items)

	end

	def search
		p = params.permit(:stags, :cat, :subcat)

		@search_tags = p[:stags].split(",").collect{|x| x.strip}
		search_cat_id = p[:cat].to_i
		search_subcat_id = p[:subcat].to_i

		@items = Item.includes(:tags)

		unless @search_tags[0] == nil
			@search_tags.each do |t|
					@items = @items.for_tag(t)
			end
		end

		if search_cat_id != 0
			@items = @items.where(category_id: search_cat_id)

			if search_subcat_id != 0
				@items = @items.where(sub_category_id: search_subcat_id)
			end
		end

		render "index"
	end

	def get_tag_names

		tags = Tag.all.map{|x| x.name}
		render json: tags
	end

	def update_subcategories
		
		cat = Category.find(params[:cat_id].to_i)
		@subcategories = cat.sub_categories

	end 

end
