class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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


end