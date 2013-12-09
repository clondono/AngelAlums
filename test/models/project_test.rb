require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "create basic project" do
  	project = Project.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0" )
    project.image =  File.new("test/fixtures/projpic.jpg")
    project.save
    assert project.title, "Water"
    assert project.video, "http://www.youtube.com/watch?v=EzQuwfoeTx8"
    assert project.description, "water works yeah!"
    assert project.goal, 200.0
    assert_not_nil project.image.url
  end

  test "youtube url editor" do
  	project = Project.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0" )
  	assert project.youtube_embed,"http://www.youtube.com/embed/EzQuwfoeTx8?wmode=transparent" 
  end

  test "test donation association" do
  	project = projects(:afri)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 300)
  	assert project.donations.length, 1
  	assert project.donations[0].amount, 300
  	assert project.donations[0].alumni.first_name, users(:tony).first_name
  end

  test "total donations method" do
  	project = projects(:afri)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 300)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 200)
  	assert project.total_donation, 500
  end

  test "test owner association" do
  	project = users(:gekko).project.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0")
  	assert project.owner.id, users(:gekko).id
  end

  test "test collaboration association" do

  end
end
