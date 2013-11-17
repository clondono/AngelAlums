class Tag < ActiveRecord::Base
	has_many :taggables
 	has_many :projects, through: :taggables
  has_many :interests
  
end
