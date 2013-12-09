require 'test_helper'

class AdvisorTest < ActiveSupport::TestCase
  test "create a advisor" do
    adv = Advisor.create(:name=> "Red", :email => "r@mit.edu")
    assert (adv.name=="Red"), "advisor name"
    assert (adv.email=="r@mit.edu"), "advisor emial"
  end
end
