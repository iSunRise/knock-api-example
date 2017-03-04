if ENV['SWAGGER']
  Knock::AuthTokenController = ApplicationController
end

class AccountTokenController < Knock::AuthTokenController
  include AccountTokenDocumentation if ENV['SWAGGER']

  def create
    if entity.two_factor_auth_enabled
      render json: { phone_number: entity.masked_phone_number, two_factor_auth: true }
    else
      render json: { jwt: auth_token.token, two_factor_auth: false }
    end
  end

  def two_factor_auth
    if PhoneVerification.code_valid?(entity.phone_number,
                                     params[:auth][:phone_verification_code])
      render json: { jwt: auth_token.token, two_factor_auth: false }
    else
      render json: { error: 'Verification code is incorrect'}, status: 401
    end
  end
end
