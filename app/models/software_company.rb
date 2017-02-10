class SoftwareCompany < ApplicationRecord
  validates :name, presence: true
  validates :name, :url_alias, :website, :vat, length: { maximum: 255 }

  has_many :accounts, dependent: :destroy
  has_many :software_company_technologies, dependent: :destroy
  has_many :technologies, through: :software_company_technologies
end
