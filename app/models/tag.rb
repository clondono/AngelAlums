class Tag < ActiveRecord::Base
	has_many :taggables
 	has_many :projects, through: :taggables
end
