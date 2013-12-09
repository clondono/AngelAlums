#Primary Author : Dongyoung Kim

class Update < ActiveRecord::Base

	validates :title, presence: true
	validates :content, presence: true
	belongs_to :project
	belongs_to :student, foreign_key: "creator_id"
	has_many :comments

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" } 


	def creator
		User.find_by(:id=>creator_id)
	end

	def has_image?
		if image_file_name != nil
			return true
		else
			return false
		end
	end
	

	# A user can delete or edit an existing Update only if he originally created it
	def can_edit?(current_user_id)
		if User.find(current_user_id) == creator
			return true
		else
			return false
		end
	end


end
