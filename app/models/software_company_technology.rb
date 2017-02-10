class SoftwareCompanyTechnology < ApplicationRecord
  belongs_to :software_company
  belongs_to :technology
  validates :software_company_id, :technology_id, presence: true
  validates :software_company_id, uniqueness: { scope: :technology_id }
end
