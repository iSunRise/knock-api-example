class SmsService
  class << self
    CLIENT = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'],
                                      ENV['TWILIO_AUTH_TOKEN'])
    RESULT = Struct.new(:success?, :error)

    def send_sms(number, text)
      CLIENT.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: normalize_phone_number(number),
        body: text
      )
      RESULT.new(true, nil)
    rescue Twilio::REST::RequestError => ex
      RESULT.new(false, ex.message)
    end

    private

    def normalize_phone_number(number)
      '+' << StringTokenizer.tokenize(number.to_s)
    end
  end
end