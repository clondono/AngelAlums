class Project < ActiveRecord::Base
    belongs_to :student, foreign_key: "owner_id"
    has_attached_file :image, 
        :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
        :default_url => "/images/:style/missing.png"
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
    accepts_nested_attributes_for :tags, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

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
        return "http://www.youtube.com/embed/"+youtube_id+"?wmode=transparent" 
      else
        return ""
      end
    end
    #return total donations made to the project
    def total_donation
        donations.sum('amount')
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

    def addCollab
        # self.collaborations.each do | collab|
        #     user = User.check_Collaborator(collab.email)
        #     collab.user_id = user.id
        #     collab.save
        # end
    end

    #return the number of donators for a project
    def number_of_donators
        donations.uniq_by(&:alum_id).length
    end

    def stripe_recipient
        return nil if stripe_recipient_id.nil?
        Stripe::Recipient.retrieve stripe_recipient_id
    end
end
