module SpecialtyDocumentation
  extend ActiveSupport::Concern

  included do
    swagger_controller :specialties, 'Specialties Controller', resource_path: 'Specialties'

    swagger_api :index do
      summary "Returns list of existing specialties (limit: 50)"
      param :path, :name, :string, :optional, "Specialty name"

      response :ok, "Success"
    end
  end
end