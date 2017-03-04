module PhoneVerifications
  class SendSMS
    include Interactor

    def call
      ActiveRecord::Base.transaction do
        if context.phone_verification.save
          send_sms
        else
          context.fail!(errors: context.phone_verification.errors)
        end
      end
    end

    private

    def send_sms
      result = SmsService.send_sms(
        context.phone_verification.phone_number,
        "Techideation verification code: #{context.phone_verification.pin_code}."
      )
      if !result.success?
        context.phone_verification.destroy
        context.fail!(errors: { phone_number: result.error })
      end
    end
  end
end
