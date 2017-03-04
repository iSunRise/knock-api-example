require 'rails_helper'

RSpec.describe PhoneVerification, type: :model do
  it { should validate_presence_of(:phone_number) }

  describe 'before_save' do
    it 'should tokenize phone number' do
      pv = PhoneVerification.create(phone_number: '+38(050)123-45-67')
      expect(pv.reload.phone_number).to eq('380501234567')
    end

    it 'should create random token' do
      pv = PhoneVerification.create(phone_number: '+38(050)123-45-67')
      expect(pv.reload.pin_token).to be_present
    end
  end

  it 'should validate phone number' do
    pv = PhoneVerification.new(phone_number: '+38(050)123-4-67')
    expect(pv).to be_invalid
  end

  describe '#masked_phone_number' do
    let(:pv) { PhoneVerification.new(phone_number: '38050123467') }

    it 'should mask part of number' do
      expect(pv.masked_phone_number).to include("-xxxx-")
    end

    it 'should add "+" at start' do
      expect(pv.masked_phone_number.start_with?('+')).to eq(true)
    end
  end

  context 'class methods' do
    describe 'PhoneVerification#pin_valid?' do
      let(:phone) { '+38(050)123-45-67' }
      let!(:pv) { PhoneVerification.create(phone_number: phone) }

      context 'with valid pin code' do
        it 'should return true' do
          expect(PhoneVerification.pin_valid?(phone, '1111')).to eq(true) # 1111 valid for test env
        end

        it 'should set validation as matched' do
          PhoneVerification.pin_valid?(phone, '1111')
          expect(pv.reload.matched).to eq(true)
        end
      end

      context 'with invalid pin code' do
        it 'should return false' do
          expect(PhoneVerification.pin_valid?(phone, '2222')).to eq(false) # 1111 valid for test env
        end

        it 'should not set validation as matched' do
          PhoneVerification.pin_valid?(phone, '2222')
          expect(pv.reload.matched).to eq(false)
        end

        it 'should increment attempts' do
          2.times { PhoneVerification.pin_valid?(phone, '2222') }
          expect(pv.reload.attempts).to eq(2)
        end
      end
    end
  end
end
