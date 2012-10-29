class AddZipCodeToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :zip_code, :integer
  end
end
