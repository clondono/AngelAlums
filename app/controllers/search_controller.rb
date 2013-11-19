class SearchController < ApplicationController
	def index
		ids = params[:search][:tag_id].reject(&:empty?)
		@projects = Project.search(ids)
		@tags = Tag.find(ids)
	end
end
