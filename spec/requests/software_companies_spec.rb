require 'rails_helper'

RSpec.describe 'Software Companies', type: :request do
  let(:account) { FactoryGirl.create(:account) }
  let(:company) { account.software_company }

  describe 'GET /api/v1/software_company' do
    before do
      get "/api/v1/software_company",
          headers: auth_header_for(account)
    end

    it 'should respond with code 200' do
      expect(response.code.to_i).to eq(200)
    end

    it 'should respond with company' do
      expect(json['software_company']['name']).to eq(company.name)
    end
  end

  describe 'PATCH /api/v1/software_company' do
    context 'with valid attributes' do
      before do
        patch "/api/v1/software_company",
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
        patch "/api/v1/software_company",
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
