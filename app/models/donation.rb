class Donation < ActiveRecord::Base
	belongs_to :alum
	belongs_to :project
end
