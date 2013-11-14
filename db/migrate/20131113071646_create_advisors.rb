class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.integer :project_id
      t.string :name
      t.string :email
      t.timestamps
    end
  end
end
