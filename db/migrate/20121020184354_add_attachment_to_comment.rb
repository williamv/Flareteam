class AddAttachmentToComment < ActiveRecord::Migration
  def up
    add_column :comments, :attachment, :string
  end

  def down
    remove_column :comments, :attachment
  end
end
