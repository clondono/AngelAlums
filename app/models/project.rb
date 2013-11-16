class Project < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	has_many :collaborations, :dependent => :destroy
    has_many :advisors, :dependent => :destroy
    has_many :taggables, :dependent => :destroy
 	has_many :tags, through: :taggables
 	accepts_nested_attributes_for :advisors, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
 	accepts_nested_attributes_for :taggables, :reject_if => lambda { |a| a[:tag_id].blank? }, :allow_destroy => true
 	accepts_nested_attributes_for :collaborations, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

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
            advisor=self.advisors.new(:project_id => self.id, :name =>advisor_params[:name], :email =>advisor_params[:email])
            advisor.save
        end
    end

    def add_tags(tags)
        tags.values.each do |tag_params|
            taggable=self.taggables.new(:project_id => self.id, :tag_id => tag_params[:tag_id])
            taggable.save
        end
    end

    def add_collaborators(collaborators)
        collaborators.values.each do |collaborator_params|
            collaborator=self.collaborations.new(:project_id => self.id, :name => collaborator_params[:name], :email => collaborator_params[:email], :user_id => nil)
            collaborator.save
        end
    end
end
