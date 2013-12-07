class CommentsController < ApplicationController
	def create
		@update = Update.find(params[:update_id])
		@comment = @update.comments.create!(comment_params)
		@comment.creator_id = current_user.id
		@comment.save

		redirect_to @update
	end

	def destroy
		@comment = Comment.find(params[:id])
		@update = Update.find(@comment.update_id)
	    @comment.destroy
    	respond_to do |format|
    		format.html { redirect_to @update }
     		format.json { head :no_content }
     	end
    end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end