class PhoneVerificationsController < ApplicationController
  include PhoneVerificationDocumentation if ENV['SWAGGER'].present?

  def create
    pv = PhoneVerification.new(phone_number: params[:phone_number])
    if pv.save
      render json: { }
    else
      render_errors(pv)
    end
  end
end
