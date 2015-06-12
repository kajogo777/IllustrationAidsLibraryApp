module ApplicationHelper

	def sortable(column, title = nil, path)
	    title ||= column.titleize
	    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
	    link_to title, "#{path}?direction=#{direction}&sort=#{column}"#(sort: column, direction: direction)
	end

end
