class AddSocialColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :string
    add_column :users, :hangout, :string
  end
end
