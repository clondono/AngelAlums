class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

#method called in order to see if an email belongs to a 
#certain user. If such a user exists they will be returned
#if not a new user with be created and that will be returned
  def check_Collaborator(email)
    @user = User.find_by_email(email)
    if @user == nil
      @user = User.create(email: email, type: "Student", password: Devise.friendly_token[0,20])
      @user.send_reset_password_instructions
    end
    @user
  end

  def send_update(project)
    send_devise_notification(:project_update, {project_title: project.title, project_id:project.id})
  end
end