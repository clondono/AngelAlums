class SearchController < ApplicationController
	def index
		if params[:search]
			ids = params[:search][:tag_id].reject(&:empty?)
			@projects = Project.search(ids)
			@tags = Tag.find(ids)
		else
			@projects = []
			@tags = []
		end
	end
end
