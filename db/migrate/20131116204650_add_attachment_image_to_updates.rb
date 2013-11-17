class AddAttachmentImageToUpdates < ActiveRecord::Migration
  def self.up
    change_table :updates do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :updates, :image
  end
end
