class OfficeSerializer < ActiveModel::Serializer
  attributes :id, :country, :city, :details, :phones, :emails,
             :working_times
end
