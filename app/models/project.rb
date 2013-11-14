class Project < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	has_many :collaborations
    has_many :advisors
    has_many :taggables
 	has_many :tags, through: :taggables
	
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

	def add_advisors(advisors)
		advisors.values.each do |advisor_params|
			advisor=self.advisor.new(advisor_params)
			advisor.save
		end
	end

	def add_tags(tags)
		tags.values.each do |tag_params|
			taggable=self.taggables.new(tag_params)
			taggable.save
		end
	end

	def add_collaborators(collaborators)
		collaborators.values.each do |collaborator_params|
			collaborator=self.collaborators.new(collaborator_params)
			collaborator.save
		end
	end
end
