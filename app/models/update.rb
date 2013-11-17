class Update < ActiveRecord::Base

	validates :title, presence: true
	validates :content, presence: true
	belongs_to :project
	# image
	# title
	# content

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" } #, :default_url => "/images/:style/missing.png"

end
