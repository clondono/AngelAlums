class AddHighlightBooleanToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :highlighted, :boolean
  end
end
