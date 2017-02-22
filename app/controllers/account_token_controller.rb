if ENV['SWAGGER']
  Knock::AuthTokenController = ApplicationController
end

class AccountTokenController < Knock::AuthTokenController
  include AccountTokenDocumentation if ENV['SWAGGER']
  def create
    if entity.two_factor_auth_enabled
      render json: { phone_number: entity.phone_number, two_factor_auth: true, message_id: 'xxx' }
    else
      render json: { jwt: auth_token.token, two_factor_auth: false }, status: :created
    end
  end

  def two_factor_auth
    if params[:auth][:phone_verification_code] == '1111'
      render json: { jwt: auth_token.token, two_factor_auth: false }, status: :created
    else
      render json: { error: 'Verification code is incorrect'}, status: 401
    end
  end
end
