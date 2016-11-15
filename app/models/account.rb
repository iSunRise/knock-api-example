class Account < ApplicationRecord
  SUPERADMIN = 'super admin'.freeze
  has_secure_password

  validates :email, :password_digest, :first_name, :last_name, presence: true
  validates :first_name, :last_name, :middle_name, :position, :email,
            length: { maximum: 255 }

  belongs_to :company, optional: true
end
