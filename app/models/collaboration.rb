class Collaboration < ActiveRecord::Base
	belongs_to :project
  belongs_to :student, foreign_key: 'user_id'
end
