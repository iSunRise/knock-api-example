module SoftwareCompanies
  module OfficeDocumentation
    extend ActiveSupport::Concern

    included do
      [:index, :update, :create, :destroy].each do |api_action|
        swagger_api api_action do
          param :header, 'Authorization', :string, :required, 'Authentication token'
        end
      end

      swagger_controller :offices, 'Offices', resource_path: 'Offices'

      swagger_api :index do
        summary "Returns offices of current account's company"
        response :ok, "Success"
        response :unauthorized
      end

      swagger_api :create do
        summary 'Creates new office for software company'

        param :form, 'office[country]', :string, :required, 'Country', limit: 255
        param :form, 'office[city]', :string, :required, 'City', limit: 255
        param :form, 'office[details]', :string, :optional, 'Details', limit: 255
        param :form, 'office[phones]', :array, :optional, 'List of phone numbers'
        param :form, 'office[emails]', :array, :optional, 'List of emails'
        param :form, 'office[working_times]', :json, :optional, 'Object like { "Monday": "9:00-18:00" } '

        response :ok, "Success"
        response :unauthorized
        response :unprocessable_entity, 'Unprocessable Entity', errors: { field: "can't be blank" }
      end

      swagger_api :update do
        summary 'Updates office'

        param :form, 'office[country]', :string, :required, 'Country', limit: 255
        param :form, 'office[city]', :string, :required, 'City', limit: 255
        param :form, 'office[details]', :string, :optional, 'Details', limit: 255
        param :form, 'office[phones]', :array, :optional, 'List of phone numbers'
        param :form, 'office[emails]', :array, :optional, 'List of emails'
        param :form, 'office[working_times]', :json, :optional, 'Object like { "Monday": "9:00-18:00" } '

        response :ok, "Success"
        response :unauthorized
        response :unprocessable_entity, 'Unprocessable Entity', errors: { field: "can't be blank" }
      end

      swagger_api :destroy do
        summary 'Removes office'

        param :path, 'id', :integer, :required, 'ID'


        response :ok, "Success"
        response :unauthorized
      end
    end
  end
end
