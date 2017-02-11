class Swagger::Docs::Config
  def self.base_api_controller; ApplicationController end
  def self.transform_path(path, _api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.register_apis(
  '1.0' => {
    controller_base_path: '',
    api_file_path: 'public/apidocs',
    base_path: "http://#{ENV['API_DOMAIN']}",
    clean_directory: true,
    api_extension_type: :json,
    attributes: {
      info: {
        title: 'TechIdeation API'
      }
    }
  }
)
