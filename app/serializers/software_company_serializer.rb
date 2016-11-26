class SoftwareCompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :url_alias, :website, :about, :logo, :background_photo,
             :number_of_employees, :contacts, :vat, :deleted, :listed
end
