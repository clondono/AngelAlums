class Project < ActiveRecord::Base
    belongs_to :student, foreign_key: "owner_id"
    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    has_many :collaborations, dependent: :destroy
    has_many :collaborators, class_name: 'Student', through: :collaborations, source: :student

    has_many :advisors, dependent: :destroy

    has_many :taggables, dependent: :destroy
    has_many :tags, through: :taggables
    
    has_many :donations
    has_many :donors, class_name: 'Alumni', through: :donations, source: :alumni
    
    belongs_to :owner, class_name: 'Student'
    
    accepts_nested_attributes_for :advisors, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
    accepts_nested_attributes_for :taggables, :reject_if => lambda { |a| a[:tag_id].blank? }, :allow_destroy => true
    accepts_nested_attributes_for :collaborations, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

    #format link to allow it to be embbed
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
    #return total donations made to the project
    def total_donation
        donations.sum('amount')
    end
    #add advisors to the project
    def add_advisors(advisors)
        if advisors != nil
            advisors.values.each do |advisor_params|
                advisor=self.advisors.new(:project_id => self.id, :name =>advisor_params[:name], :email =>advisor_params[:email])
                advisor.save
            end
        end
    end
    #add tags to project
    def add_tags(tags)
        if tags != nil
            tags = tags.values[0][:tag_id]
            tags.each do |tag_params|
                if tag_params != ""
                    taggable=self.taggables.new(:project_id => self.id, :tag_id => tag_params)
                    taggable.save
                end
            end
        end
    end
    #add collaborators
    def add_collaborators(collaborators)
        if collaborators != nil
            collaborators.values.each do |collaborator_params|
                collaborator=self.collaborations.new(:project_id => self.id, :name => collaborator_params[:name], :email => collaborator_params[:email])
                user = User.find_by_email(collaborator_params[:email])
                if user
                    collaborator.user_id = user.id
                end
                collaborator.save
            end
        end
    end
    #return whether the user is a owner, collaborator or none of the project
    def access_level(user_id)
        colab = self.collaborations.where(:user_id => user_id)
        if user_id == self.student.id
            return "owner"
        elsif colab.length != 0
            return "collaborator"
        else 
            return "none"
        end
    end

    def self.search(tag_ids)
        Project.joins(:tags).where(:tags => {:id => tag_ids})
    end
end
