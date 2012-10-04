class CreateActivations < ActiveRecord::Migration
  def change
    create_table :activations do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :location, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
