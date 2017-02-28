class SoftwareCompany < ApplicationRecord
  validates :name, presence: true
  validates :name, :url_alias, :website, :vat, length: { maximum: 255 }

  has_many :accounts, dependent: :destroy
  has_many :software_company_technologies, dependent: :destroy
  has_many :technologies, through: :software_company_technologies
  has_many :software_company_specialties, dependent: :destroy
  has_many :specialties, through: :software_company_specialties

  accepts_nested_attributes_for :technologies
  accepts_nested_attributes_for :specialties

  mount_uploader :logo, LogoUploader
  mount_uploader :background_photo, BackgroundPhotoUploader

  def technologies_names=(names)
    handle_nested_list(names, Technology)
  end

  def specialties_names=(names)
    handle_nested_list(names, Specialty)
  end

  private

  def handle_nested_list(names, resource_class)
    ids_field = resource_class.to_s.downcase + '_ids'
    attributes_field = resource_class.to_s.downcase.pluralize(2) + '_attributes'
    names_tokens = names.map do |n|
      next if n.blank?
      [n, StringTokenizer.tokenize(n)]
    end.compact.to_h
    if names_tokens.empty?
      self[ids_field] = []
      return
    end
    ActiveRecord::Base.transaction do
      records = resource_class.where(token: names_tokens.values)
      # connect existing records or clear them by sending empty array
      send("#{ids_field}=", records.map(&:id))
      if records.present?
        existing_tokens = records.map(&:token)
        names_tokens.reject! { |_n, token| existing_tokens.include?(token) }
      end
      # create new records
      list_to_create = names_tokens.map do |name, _t|
        { name: name }
      end.compact
      send("#{attributes_field}=", list_to_create)
      save
    end
  end
end
