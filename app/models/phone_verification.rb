class PhoneVerification < ApplicationRecord
  before_save :tokenize_number, :generate_pin_code
  validates :phone_number, presence: true, phone: true

  def self.find_by_number(phone)
    find_by(phone_number: StringTokenizer.tokenize(phone), matched: false)
  end

  def pin_valid?(pin_code)
    if BCrypt::Password.new(pin_token) == pin_code
      update_columns(matched: true)
      true
    else
      update_columns(attempts: attempts + 1)
      false
    end
  end

  private

  def tokenize_number
    self.phone_number = StringTokenizer.tokenize(phone_number)
  end

  def generate_pin_code
    self.pin_token = BCrypt::Password.create(pin_code)
    # TODO: send pin code to mobile device
  end

  def pin_code
    # TODO: for now just use 1111 everytime
    # actually should be: rand(100000..999999)
    '1111'
  end
end
