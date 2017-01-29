class Account < ApplicationRecord
  include TokenAuthenticable
  SUPERADMIN = 'superadmin'.freeze
  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :software_company_name, presence: true, on: :create
  validates :password, presence: true, on: :create
  validates :first_name, :last_name, :middle_name, :position, :email,
            length: { maximum: 255 }
  validates :email, uniqueness: true
  validates_with CorporateEmailValidator

  belongs_to :software_company

  attr_accessor :software_company_name
end
