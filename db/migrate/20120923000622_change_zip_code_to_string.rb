class ChangeZipCodeToString < ActiveRecord::Migration
  def up
    change_column :organizations, :zip_code, :string
  end

  def down
    change_column :organizations, :zip_code, :integer
  end
end
