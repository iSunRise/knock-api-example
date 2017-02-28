class SoftwareCompanySpecialty < ApplicationRecord
  belongs_to :software_company
  belongs_to :specialty
  validates :software_company_id, :specialty_id, presence: true
  validates :software_company_id, uniqueness: { scope: :specialty_id }
end
