class Project < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	has_many :collaborations
    has_many :advisors
    has_many :taggables
 	has_many :tags, through: :taggables
 	accepts_nested_attributes_for :advisors
 	accepts_nested_attributes_for :tags
	accepts_nested_attributes_for :collaborations

	
	def youtube_embed
	  if self.video[/youtu\.be\/([^\?]*)/]
	    youtube_id = $1
	  else
	    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
	    self.video[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
	    youtube_id = $5
	  end
	  if youtube_id
	  	return "http://www.youtube.com/embed/"+youtube_id 
	  else
	  	return ""
	  end
	end

	
end
