class AccountSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :middle_name, :position, :email,
             :roles, :photo, :phone_number, :two_factor_auth_enabled
end
