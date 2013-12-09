class AddStripeRecipientIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :stripe_recipient_id, :string
  end
end
