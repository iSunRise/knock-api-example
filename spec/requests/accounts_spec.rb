require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:account) { FactoryGirl.create(:account) }

  describe 'GET /api/v1/account' do
    before do
      get '/api/v1/account', headers: auth_header_for(account)
    end

    it 'should respond with code 200' do
      expect(response.code.to_i).to eq(200)
    end

    it 'should respond with account' do
      expect(json['account']['id'].to_i).to eq(account.id)
    end
  end

  describe 'POST /api/v1/account' do
    before do
      PhoneVerification.create(phone_number: '380631234567')
    end

    context 'with valid attributes' do
      subject do
        @account_params = FactoryGirl.attributes_for(:account).merge(
          software_company_name: '4x4 solutions',
          phone_verification_code: '1111',
          phone_number: '380631234567'
        )
        post '/api/v1/account', params: { account: @account_params }
      end

      it 'should respond with code 200' do
        expect(subject.to_i).to eq(200)
      end

      it 'should create new account' do
        expect { subject }.to change(Account, :count).by(1)
      end

      it 'should create new software company' do
        expect { subject }.to change(SoftwareCompany, :count).by(1)
      end

      it 'should associate account with software company' do
        subject
        expect(Account.last.software_company.name).to eq('4x4 solutions')
      end

      it 'should respond with jwt token' do
        subject
        expect(json['jwt']).to be_present
      end
    end

    context 'with invalid attributes' do
      subject do
        @account_params = FactoryGirl.attributes_for(:account).merge(
          software_company_name: '4x4 solutions', email: nil
        )
        post '/api/v1/account', params: { account: @account_params }
      end

      it 'should respond with code 422' do
        expect(subject.to_i).to eq(422)
      end

      it 'should not create new account' do
        expect { subject }.to change(Account, :count).by(0)
      end

      it 'should not create new software company' do
        expect { subject }.to change(SoftwareCompany, :count).by(0)
      end

      it 'should respond with errors' do
        subject
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'PATCH /api/v1/account' do
    context 'with valid attributes' do
      before do
        patch '/api/v1/account', params: {
          account: { last_name: 'Chingachgook' }
        },
        headers: auth_header_for(account)
      end

      it 'should respond with code 200' do
        expect(response.code.to_i).to eq(200)
      end

      it 'should update account' do
        expect(account.reload.last_name).to eq('Chingachgook')
      end

      it 'should respond with account' do
        expect(json['account']['id'].to_i).to eq(account.id)
      end
    end

    context 'with valid attributes' do
      before do
        patch '/api/v1/account', params: {
          account: { email: '', first_name: '0x00' }
        },
        headers: auth_header_for(account)
      end

      it 'should respond with code 422' do
        expect(response.code.to_i).to eq(422)
      end

      it 'should not update account' do
        old_first_name = account.first_name.dup
        expect(account.reload.first_name).to eq(old_first_name)
      end

      it 'should respond with errors' do
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'DELETE /api/v1/account' do
    before do
      delete '/api/v1/account', headers: auth_header_for(account)
    end

    it 'should respond with 200' do
      expect(response.code.to_i).to eq(200)
    end
  end
end
