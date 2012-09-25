class Organization < ActiveRecord::Base
  has_many :users

  attr_accessible :city, :zip_code, :emergency_role, :employee_count_range, 
    :name, :phone, :primary_contact_email, :primary_contact_name, 
    :primary_contact_phone, :state, :street_address

  validates :name, :primary_contact_name, :primary_contact_phone,
    :emergency_role, presence: true
end
