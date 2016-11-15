class SoftwareCompany < ApplicationRecord
  validates :name, presence: true
  validates :name, :url_alias, :website, :vat, length: { maximum: 255 }

  has_many :account, dependent: :destroy
end
