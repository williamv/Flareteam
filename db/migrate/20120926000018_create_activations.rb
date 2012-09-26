class CreateActivations < ActiveRecord::Migration
  def change
    create_table :activations do |t|
      t.string :title
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
