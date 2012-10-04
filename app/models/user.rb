class User < ActiveRecord::Base
  belongs_to :organization
  has_many :activations
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :first_name, :last_name, :emergency_role, :mobile_phone_number,
  validates :organization, :email, :first_name, :last_name, :emergency_role, :mobile_phone_number,
    :landline_phone_number, presence: true

  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :first_name, :last_name, :emergency_role, :street_address, :city, :state, 
    :country, :mobile_phone_number, :landline_phone_number
    :country, :mobile_phone_number, :landline_phone_number, :organization_id

  def full_name
    [first_name, last_name].join(" ")
  end
end
