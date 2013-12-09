require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name method" do
  	assert_equal users(:tony).name , "Tony Stark"
  end

  test "chack collaboration method" do

  end

  # Most of the stuff for user id handled by devise to no need to test, more information
  # about devise can be found here https://github.com/plataformatec/devise/wiki.

  # Also all associations are with project model and these associations are tested in the project
  # model test.
end
