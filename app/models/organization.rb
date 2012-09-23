class Organization < ActiveRecord::Base
  attr_accessible :city, :zip_code, :emergency_role, :employee_count_range, 
    :name, :phone, :primary_contact_email, :primary_contact_name, 
    :primary_contact_phone, :state, :street_address

  validates :name, presence: true
end
