module PhoneVerificationDocumentation
  extend ActiveSupport::Concern

  included do
    swagger_controller :phone_verifications, 'Phone Verifications Controller', resource_path: 'Phone Verification'

    swagger_api :create do
      summary "Requests new verification"
      param :form, :phone_number, :string, :required, "Valid phone number"

      response :ok, "Success"
      response :unprocessable_entity, 'Unprocessable Entity'
    end
  end
end