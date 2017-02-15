require 'rails_helper'

RSpec.describe PhoneVerification, type: :model do
  it { should validate_presence_of(:number) }

  describe 'before_save' do
    it 'should tokenize phone number' do
      pv = PhoneVerification.create(number: '+38(050)123-45-67')
      expect(pv.reload.number).to eq('380501234567')
    end

    it 'should create random token' do
      pv = PhoneVerification.create(number: '+38(050)123-45-67')
      expect(pv.reload.pin_token).to be_present
    end
  end

  it 'should validate phone number' do
    pv = PhoneVerification.new(number: '+38(050)123-4-67')
    expect(pv).to be_invalid
  end

  describe '#pin_valid?' do
    let(:pv) { PhoneVerification.create(number: '+38(050)123-45-67') }

    context 'with valid pin code' do
      it 'should return true' do
        expect(pv.pin_valid?('1111')).to eq(true) # 1111 valid for test env
      end

      it 'should set validation as matched' do
        pv.pin_valid?('1111')
        expect(pv.reload.matched).to eq(true)
      end
    end

    context 'with invalid pin code' do
      it 'should return false' do
        expect(pv.pin_valid?('2222')).to eq(false) # 1111 valid for test env
      end

      it 'should not set validation as matched' do
        pv.pin_valid?('2222')
        expect(pv.reload.matched).to eq(false)
      end

      it 'should increment attempts' do
        2.times { pv.pin_valid?('2222') }
        expect(pv.reload.attempts).to eq(2)
      end
    end
  end
end
