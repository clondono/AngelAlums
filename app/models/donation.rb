class Donation < ActiveRecord::Base
	#Donation belongs to both alumni and project
	belongs_to :alumni, foreign_key: 'alum_id'
	belongs_to :project
end
