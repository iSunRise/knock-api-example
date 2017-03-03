class Office < ApplicationRecord
  belongs_to :software_company

  validates :country, :city, presence: true
end
