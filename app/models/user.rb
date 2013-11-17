class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

def check_Collaborator(email)
  @user = User.find_by_email(email)
  if @user == nil
    @user = User.create(email: email, password: Devise.friendly_token[0,20])
    @user.send_reset_password_instructions
  end
  @user
end
