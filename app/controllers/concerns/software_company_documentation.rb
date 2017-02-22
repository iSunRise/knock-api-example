module SoftwareCompanyDocumentation
  extend ActiveSupport::Concern

  included do
    [:show, :update].each do |api_action|
      swagger_api api_action do
        param :header, 'Authorization', :string, :required, 'Authentication token'
      end
    end

    swagger_controller :software_companies, 'Software Companies Controller', resource_path: 'Software (Outsourcing) Companies'

    swagger_api :show do
      summary "Returns current account's company"
      response :ok, "Success"
      response :unauthorized
    end

    swagger_api :update do
      summary 'Updates software company record'

      param :form, 'software_company[name]', :string, :optional, 'Name', limit: 255
      param :form, 'software_company[url_alias]', :string, :optional,        'Ulr alias'
      param :form, 'software_company[website]', :string, :optional,          'Website'
      param :form, 'software_company[about]', :string, :optional,              'About text'
      param :form, 'software_company[logo]', :file, :optional,               'Logo file'
      param :form, 'software_company[background_photo]', :file, :optional, 'Backround logo file'
      param :form, 'software_company[number_of_employees]', :integer, :optional, 'Number of employees'
      param :form, 'software_company[contacts]', :string, :optional,           'Contacts text'
      param :form, 'software_company[vat]', :string, :optional,              'VAT code'
      param :form, 'software_company[listed]', :boolean, :optional,           'Visible on site'
      param :form, 'software_company[technologies_names]', :array, :optional,           'List of technologies (array of strings)'

      response :ok, "Success"
      response :unauthorized
      response :unprocessable_entity, 'Unprocessable Entity', errors: { field: "can't be blank" }
    end
  end
end
