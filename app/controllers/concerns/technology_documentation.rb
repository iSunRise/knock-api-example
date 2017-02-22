module TechnologyDocumentation
  extend ActiveSupport::Concern

  included do
    swagger_controller :technologies, 'Technologies Controller', resource_path: 'Technologies'

    swagger_api :index do
      summary "Returns list of existing technologies"
      param :path, :name, :string, :optional, "Technology name"

      response :ok, "Success"
    end
  end
end