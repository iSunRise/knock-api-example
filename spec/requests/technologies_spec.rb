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
end
