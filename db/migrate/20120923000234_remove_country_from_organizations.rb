class RemoveCountryFromOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :country
  end

  def down
    add_column :organizations, :country, :string
  end
end
