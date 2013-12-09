require 'test_helper'

class CollaborationTest < ActiveSupport::TestCase
  test "create a collaborator" do
    col = Collaboration.create(:name=> "Red", :email => "r@mit.edu")
    assert (col.name=="Red"), "Collaboration name"
    assert (col.email=="r@mit.edu"), "Collaboration emial"
  end
end
