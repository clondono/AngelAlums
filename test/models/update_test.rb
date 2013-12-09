require 'test_helper'

class UpdateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "creator association" do
  	@gekko = users(:gekko)
  	@budfox = users(:budfox)
  	@comment_a = comments(:comment_a)
  	@comment_b = comments(:comment_b)
  	@update_a = updates(:update_a)
  	@update_b = updates(:update_b)

  	puts @update_b.creator.email

  	assert (@comment_a.creator == @gekko), "test 1 in creator test failed"
  	assert (@update_b.creator == @budfox), "test 2 in creator test failed"
  end

  test "user-update association" do
    @gekko = users(:gekko)
    @budfox = users(:budfox)

    @update = @gekko.updates.create(:title=>"title", :content=>"text")
    @update.save
    assert (@update.creator == @gekko), "test 1 in editor test failed"
  end

  test "update-comment-user association" do
    
  end
end
