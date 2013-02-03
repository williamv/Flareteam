class CreateOrganizationInvitationRequests < ActiveRecord::Migration
  def change
    create_table :organization_invitation_requests do |t|
      t.integer :organization_id, null: false
      t.integer :requester_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
