class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :project_id
      t.integer :alum_id

      t.timestamps
    end
  end
end
