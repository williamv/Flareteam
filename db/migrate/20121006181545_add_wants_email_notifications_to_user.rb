class AddWantsEmailNotificationsToUser < ActiveRecord::Migration
  def change
    add_column :users, 
      :wants_email_notifications, 
      :boolean, 
      default: true, 
      null: false
  end
end
