require 'rails_helper'

RSpec.describe 'Phone Verifications', type: :request do

  describe 'POST /api/v1/phone_verifications' do
    context 'with valid phone number' do
      before do
        post '/api/v1/phone_verifications',
             params: { phone_number: '380631234567'}
      end

      it 'should respond with 200OK' do
        expect(response.code.to_i).to eq(200)
      end

      it 'should create phone verification record' do
        expect(PhoneVerification.last.phone_number).to eq('380631234567')
      end
    end

    context 'with invalid phone number' do
      before do
        post '/api/v1/phone_verifications',
             params: { phone_number: '38063123456'}
      end

      it 'should respond with 422' do
        expect(response.code.to_i).to eq(422)
      end

      it 'should not create phone verification record' do
        expect(PhoneVerification.count).to eq(0)
      end

      it 'should respond with errors' do
        expect(json['errors']['phone_number']).to be_present
      end
    end
  end
end
