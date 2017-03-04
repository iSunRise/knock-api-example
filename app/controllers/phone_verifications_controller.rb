class PhoneVerificationsController < ApplicationController
  include PhoneVerificationDocumentation if ENV['SWAGGER'].present?

  def create
    pv = PhoneVerification.new(phone_number: params[:phone_number])
    result = PhoneVerifications::SendSMS.call(phone_verification: pv)
    if result.success?
      render json: { }
    else
      render_errors(nil, result.errors)
    end
  end
end
