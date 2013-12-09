require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "create basic project" do
  	project = Project.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0" )
    project.image =  File.new("test/fixtures/projpic.jpg")
    project.save
    assert_equal project.title, "Water"
    assert_equal project.video, "http://www.youtube.com/watch?v=EzQuwfoeTx8"
    assert_equal project.description, "water works yeah!"
    assert_equal project.goal, 200.0
    assert_not_nil project.image.url
  end

  test "youtube url editor" do
  	project = Project.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0" )
  	assert_equal project.youtube_embed,"http://www.youtube.com/embed/EzQuwfoeTx8?wmode=transparent" 
  end

  test "test donation association" do
  	project = projects(:afri)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 300)
  	assert_equal project.donations.length, 1
  	assert_equal project.donations[0].amount, 300
  	assert_equal project.donations[0].alumni.first_name, users(:tony).first_name
  end

  test "test donors association" do
  	project = projects(:afri)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 300)
  	assert_equal project.donors.length, 1
  	assert_equal project.donors[0].first_name, users(:tony).first_name
  end

  test "total donations method" do
  	project = projects(:afri)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 300)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 200)
  	assert_equal project.total_donation, 500
  end

  test "test owner association" do
  	project = users(:gekko).projects.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0")
  	assert_equal project.owner.id, users(:gekko).id
  end

  test "test collaboration association" do
  	project = users(:gekko).shared_projects.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0")
  	assert_equal project.collaborators[0].id, users(:gekko).id
  end

  test "test tag association" do 
  	project = projects(:afri)
  	project.taggables.create(:tag_id => tags(:home))
  	assert_equal project.tags.length, 1
  	project.taggables.create(:tag_id => tags(:blue))
  	assert_equal project.tags.length, 2
  end

  test "test access level method" do
  	project = users(:gekko).projects.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0")
  	assert_equal project.access_level(users(:gekko).id), "owner"

  	proj = users(:gekko).shared_projects.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0")
  	assert_equal project.access_level(users(:gekko).id), "collaborator"

  	assert_equal project.access_level(users(:tony).id), "none"
  end
end
