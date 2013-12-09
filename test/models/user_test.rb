require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name method" do
  	assert_equal users(:tony).name , "Tony Stark"
  end

  test "check collaboration (already existing user ) method" do
  	user = User.check_Collaborator(users(:gekko).email)
  	assert_equal user.name, users(:gekko).name
  end

  # test "check collaboration (non existing user ) method" do
  # 	user = User.check_Collaborator("blah@mit.edu")
  # 	assert_equal user.email, "blah@mit.edu"
  # end
  #this method could not run because it did not have acces to information in the config
  #file which we did not know how to import that here

  # Most of the stuff for user id handled by devise to no need to test, more information
  # about devise can be found here https://github.com/plataformatec/devise/wiki.

  # Also all associations are with project model and these associations are tested in the project
  # model test.
end
