class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.boolean :wants_email_notifications, 
        null: false, 
        default: true

      t.timestamps
    end
  end
end
