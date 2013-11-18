class AddCreatorIdToUpdate < ActiveRecord::Migration
  def change
  	add_column :updates, :creator_id, :integer
  end
end
