class AddAttachmentToComment < ActiveRecord::Migration
  def change
    add_column :comments, :attachment, :string
  end
end
