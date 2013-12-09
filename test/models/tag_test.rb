require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "create a tag" do
    tag = Tag.create(:title=> "Red", :description => "color")
    assert (tag.title=="Red"), "tag title checked"
    assert (tag.description=="color"), "tag description checked"
  end

  test "create a tag missing description" do
    tag = Tag.create(:title=> "Red")
    assert (tag.title=="Red"), "tag title checked"
    assert (tag.description==nil), "tag description checked"
  end
end
