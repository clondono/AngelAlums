class AddTags < ActiveRecord::Migration
  def change
  	Tag.create(:title => "Health", :description => "this project relates to health sector")
  	Tag.create(:title => "Technology", :description => "this project relates to technology")
  	Tag.create(:title => "Social", :description => "this is a social project")
  	Tag.create(:title => "Engineering", :description => "engineering project")
  	Tag.create(:title => "Sports", :description => "this project relates to sports")
  	Tag.create(:title => "Arts", :description => "this project relates to arts")
  	Tag.create(:title => "Music", :description => "music related project")
  	Tag.create(:title => "Economics", :description => "this project relates to economics")
  	Tag.create(:title => "Charity", :description => "charity related project")
  	Tag.create(:title => "Political Science", :description => "this project relates to political science")
  end
end
