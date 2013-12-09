require 'test_helper'

class UpdateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def test_creator
  	@gekko = users(:gekko)
  	@budfox = users(:budfox)
  	@comment_a = comments(:comment_a)
  	@comment_b = comments(:comment_b)
  	@update_a = updates(:update_a)
  	@update_b = updates(:update_b)

  	puts @comment_b.creator
  	puts @update_b.creator

  	assert (@comment_a.creator == @gekko), "test 1 in creator test failed"
  	assert (@update_b.creator == @budfox), "test 2 in creator test failed"
  end

  def
    
  end
end
