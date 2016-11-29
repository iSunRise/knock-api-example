class Account < ApplicationRecord
  include TokenAuthenticable
  SUPERADMIN = 'superadmin'.freeze
  has_secure_password

  validates :email, :password_digest, :first_name, :last_name, presence: true
  validates :software_company_name, presence: true, on: :create
  validates :first_name, :last_name, :middle_name, :position, :email,
            length: { maximum: 255 }
  validates_with CorporateEmailValidator

  belongs_to :software_company, optional: true

  attr_accessor :software_company_name
end
