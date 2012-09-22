class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :first_name, :last_name, :organization_name, 
    :emergency_role, :mobile_phone_number, :landline_phone_number,
    presence: true

  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :first_name, :last_name, :organization_name, :emergency_role, 
    :street_address, :city, :state, :country, :mobile_phone_number, 
    :landline_phone_number
end
