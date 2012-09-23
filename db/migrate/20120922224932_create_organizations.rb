class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :primary_contact_name
      t.string :primary_contact_phone
      t.string :primary_contact_email
      t.text :emergency_role
      t.string :employee_count_range

      t.timestamps
    end
  end
end
