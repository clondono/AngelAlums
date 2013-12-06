class CommentsController < ApplicationController
	def create
		@update = Update.find(params[:update_id])
		@comment = @update.comments.create!(comment_params)
		@comment.creator_id = current_user.id
		@comment.save

		redirect_to @update
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end