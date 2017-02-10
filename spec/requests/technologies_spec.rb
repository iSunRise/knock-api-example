require 'rails_helper'

RSpec.describe 'Technologies', type: :request do
  let(:account) { FactoryGirl.create(:account) }

  describe 'GET /api/v1/technologies' do
    before do
      FactoryGirl.create_list(:technology, 3)

      get '/api/v1/technologies'
    end

    it 'should respond with code 200' do
      expect(response.code.to_i).to eq(200)
    end

    it 'should respond with 3 technologies' do
      expect(json['technologies'].count).to eq(3)
    end
  end

  describe 'GET /api/v1/technologies?name=query' do
    before do
      FactoryGirl.create(:technology, name: 'one tech')
      FactoryGirl.create(:technology, name: 'second')
      FactoryGirl.create(:technology, name: 'third tech')

      get '/api/v1/technologies?name=tECh'
    end

    it 'should return filtered results' do
      expect(json['technologies'].map{|x| x['name']}).to(
        match_array(['one tech', 'third tech'])
      )
    end

  end


  describe 'POST /api/v1/technologies' do
    context 'with valid attributes' do
      before do
        post '/api/v1/technologies',
             params: { technology: { name: 'Supep puper tech' } },
             headers: auth_header_for(account)
      end

      it 'should respond with code 200' do
        expect(response.code.to_i).to eq(200)
      end

      it 'should create technology' do
        expect(Technology.last.name).to eq('Supep puper tech')
      end

      it 'should respond with technology' do
        expect(json['technology']['id'].to_i).to eq(Technology.last.id)
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/technologies',
             params: { technology: { name: '' } },
             headers: auth_header_for(account)
      end

      it 'should respond with code 422' do
        expect(response.code.to_i).to eq(422)
      end

      it 'should not create technology' do
        expect(Technology.count).to be_zero
      end

      it 'should respond with errors' do
        expect(json['errors']).to be_present
      end
    end
  end
end
