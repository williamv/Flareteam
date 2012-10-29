class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :primary_contact_name, null: false
      t.string :primary_contact_phone, null: false
      t.string :primary_contact_email
      t.text :emergency_role, null: false
      t.string :employee_count_range

      t.timestamps
    end
  end
end
