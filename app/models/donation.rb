class Donation < ActiveRecord::Base
	belongs_to :alumni, foreign_key: 'alum_id'
	belongs_to :project
end
