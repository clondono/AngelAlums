class Update < ActiveRecord::Base

	validates :title, presence: true
	validates :content, presence: true
	belongs_to :project
	belongs_to :student, foreign_key: "creator_id"
	# image
	# title
	# content

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" } #, :default_url => "/images/:style/missing.png"


	def creator
		return student
	end

	def has_image?
		if image_file_name != nil
			return true
		else
			return false
		end
	end
	

	def can_edit?(current_user_id)
		if User.find(current_user_id) == creator
			return true
		else
			return false
		end
	end


end
