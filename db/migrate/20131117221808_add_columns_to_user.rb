class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :grad_year, :integer
    add_column :users, :major, :integer
  end
end
