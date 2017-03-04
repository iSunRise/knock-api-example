class PhoneVerification < ApplicationRecord
  before_save :tokenize_number, :generate_pin_code
  validates :phone_number, presence: true, phone: true

  scope :fresh, -> { where('created_at > ?', Time.zone.now - 10.minutes) }
  scope :unmatched, -> { where(matched: false) }

  attr_reader :pin_code

  def self.pin_valid?(phone_number, pin_code)
    pv = fresh.unmatched.find_by(phone_number: StringTokenizer.tokenize(phone_number))
    pv.present? && pv.pin_valid?(pin_code)
  end

  def pin_valid?(pin_code)
    if BCrypt::Password.new(pin_token) == pin_code || (pin_code == '1111' && ENV['SMS_TEST_MODE'])
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
    @pin_code = Rails.env.test? ? '1111' : rand(100000..999999)
    self.pin_token = BCrypt::Password.create(@pin_code)
  end
end
