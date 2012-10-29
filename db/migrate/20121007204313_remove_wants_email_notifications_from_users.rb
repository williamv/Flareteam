class RemoveWantsEmailNotificationsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :wants_email_notifications
  end

  def down
    add_column :users, :wants_email_notifications, :boolean, null: false, default: true
  end
end
