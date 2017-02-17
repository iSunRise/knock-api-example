class SoftwareCompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :url_alias, :website, :about, :logo_url,
             :background_photo_url,
             :number_of_employees, :contacts, :vat, :deleted, :listed
end
