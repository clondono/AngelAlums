class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.attachment :image
      t.string :video
      t.text :description
      t.float :goal
      t.timestamps
    end
  end
end
