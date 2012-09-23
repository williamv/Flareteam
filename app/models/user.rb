class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :email, :organization_name, 
    :emergency_role, presence: true

  attr_accessible :email, :password, :password_confirmation, :first_name, 
    :last_name, :organization_name, :emergency_role, :street_address, 
    :city, :state, :country, :mobile_phone_number, :landline_phone_number
end
