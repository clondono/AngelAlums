class Taggable < ActiveRecord::Base
	belongs_to :project
	belongs_to :tag
end
