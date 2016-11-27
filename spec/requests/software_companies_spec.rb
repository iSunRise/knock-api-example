require 'rails_helper'

RSpec.describe 'Software Companies', type: :request do
  let(:account) { FactoryGirl.create(:account) }
  let(:company) do
    FactoryGirl.create(:software_company, account_ids: [account.id])
  end

  describe 'GET /api/v1/software_companies/:id' do
    before do
      get "/api/v1/software_companies/#{company.id}",
          headers: auth_header_for(account)
    end

    it 'should respond with code 200' do
      expect(response.code.to_i).to eq(200)
    end

    it 'should respond with company' do
      expect(json['software_company']['name']).to eq(company.name)
    end
  end

  describe 'PATCH /api/v1/software_companies/:id' do
    context 'with valid attributes' do
      before do
        patch "/api/v1/software_companies/#{company.id}",
        params: { software_company: { name: 'Roga i Kopita' } },
        headers: auth_header_for(account)
      end

      it 'should respond with code 200' do
        expect(response.code.to_i).to eq(200)
      end

      it 'should update account' do
        expect(company.reload.name).to eq('Roga i Kopita')
      end

      it 'should respond with company' do
        expect(json['software_company']['id'].to_i).to eq(company.id)
      end
    end

    context 'with invalid attributes' do
      before do
        patch "/api/v1/software_companies/#{company.id}",
              params: { software_company: { name: '' } },
              headers: auth_header_for(account)
      end

      it 'should respond with code 422' do
        expect(response.code.to_i).to eq(422)
      end

      it 'should not update company' do
        old_name = company.name.dup
        expect(company.reload.name).to eq(old_name)
      end

      it 'should respond with errors' do
        expect(json['errors']).to be_present
      end
    end
  end
end
