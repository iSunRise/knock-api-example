class SoftwareCompany < ApplicationRecord
  validates :name, presence: true
  validates :name, :url_alias, :website, :vat, length: { maximum: 255 }

  has_many :accounts, dependent: :destroy
  has_many :software_company_technologies, dependent: :destroy
  has_many :technologies, through: :software_company_technologies

  accepts_nested_attributes_for :technologies

  def [](val)
    if val.to_s == 'technologies_names'
      technologies.pluck :name
    else
      super
    end
  end

  def technologies_names=(names)
    names_tokens = names.map do |n|
      next if n.blank?
      [n, StringTokenizer.tokenize(n)]
    end.compact.to_h
    if names_tokens.empty?
      self.technology_ids = []
      return
    end
    ActiveRecord::Base.transaction do
      techs = Technology.where(token: names_tokens.values)
      self.technology_ids = techs.map(&:id)
      technology_tokens = techs.map(&:token)
      names_tokens.reject! { |_n, token| technology_tokens.include?(token) }
      self.technologies_attributes = names_tokens.map do |name, token|
        { name: name }
      end.compact
      save
    end
  end
end
