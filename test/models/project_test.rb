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
  	project.taggables.create(:tag_id => tags(:home).id)
  	project.taggables.create(:tag_id => tags(:blue).id)
  	assert_equal project.tags.length, 2
  end

  test "test access level method" do
  	project = users(:gekko).projects.create(:title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0")
  	assert_equal project.access_level(users(:gekko).id), "owner"

  	proj = users(:budfox).shared_projects.create(:owner_id => users(:gekko).id, :title => "Water", :video => "http://www.youtube.com/watch?v=EzQuwfoeTx8", :description => "water works yeah!", :goal => "200.0")
  	assert_equal proj.access_level(users(:budfox).id), "collaborator"

  	assert_equal project.access_level(users(:tony).id), "none"
  end

  test "search single result" do
  	project = projects(:afri)
  	project.taggables.create(:tag_id => tags(:home).id)

  	results = Project.search(tags(:home).id)
  	assert_equal results[0].title, projects(:afri).title
  end

  test "search multiple method" do 
  	project = projects(:afri)
  	project.taggables.create(:tag_id => tags(:home).id)

  	proj = projects(:Project_webgame)
  	proj.taggables.create(:tag_id => tags(:home).id)


  	results = Project.search(tags(:home).id)
  	assert_equal results.length, 2
  end

  test "number of donators method" do
  	project = projects(:afri)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 300)
  	project.donations.create( :alum_id => users(:tony).id, :amount => 200)
  	project.donations.create( :alum_id => users(:richard).id, :amount => 200)
  	assert_equal project.number_of_donators, 2
  end

  test "add collaborator method" do
    project = projects(:afri)
    project.collaborations.create(:name => users(:gekko).name ,:email => users(:gekko).email)
    project.addCollab
    assert users(:gekko).shared_projects.include?(project)
  end
end
