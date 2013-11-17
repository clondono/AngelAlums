class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :project_id
      t.string :name
      t.string :email
      t.integer :user_id
      t.timestamps
    end
  end
end
