class MoveActivationsIdToOrganizations < ActiveRecord::Migration
  def up
    remove_column :activations, :user_id
    add_column :activations, :organization_id, :integer
  end

  def down
    remove_column :activations, :organization_id
    add_column :activations, :user_id, :integer
  end
end
