class CreateTaggables < ActiveRecord::Migration
  def change
    create_table :taggables do |t|
      t.integer :project_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
