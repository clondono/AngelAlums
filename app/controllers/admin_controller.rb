class AdminController < ApplicationController
	before_action :authenticate_admin, only: [:admin]

 	# GET /admin
	def admin
		@projects = Project.all

		respond_to do |format|
			format.html
		end

	end

	# POST /admin_post
	def admin_post
		highlight_id = params[:highlight_id]
		@project = Project.find_by(id: highlight_id)
		@project.highlighted = ! @project.highlighted
		@project.save

		respond_to do |format|
			format.js {  }
		end
	end

	private

	def authenticate_admin
		authenticate_or_request_with_http_basic('Administration') do |name, password|
			name == "admin" && password == "password"
		end
	end
end