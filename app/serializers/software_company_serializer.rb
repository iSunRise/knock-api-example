class SoftwareCompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :url_alias, :website, :about, :logo_url,
             :background_photo_url, :average_hourly_rate, :minimum_project_size,
             :foundation_date, :number_of_employees, :contacts, :vat, :deleted,
             :listed, :technologies_names, :specialties_names

  def technologies_names
    object.technologies.pluck(:name)
  end

  def specialties_names
    object.specialties.pluck(:name)
  end
end
