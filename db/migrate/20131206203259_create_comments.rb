class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.integer :update_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
