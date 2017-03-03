require 'rails_helper'

RSpec.describe 'SoftwareCompanies::Offices', type: :request do
  let(:software_company) { create(:software_company) }
  let(:account) { create(:account, software_company: software_company) }
  let(:office) { create(:office, software_company: software_company) }

  describe '#show' do
    subject do
      get "/api/v1/software_company/offices",
          headers: auth_header_for(account)
    end

    it "should respond with 200ok" do
      expect(subject.to_i).to eq(200)
    end

    it 'should respond with list of offices' do
      create_list(:office, 3, software_company: software_company)
      create_list(:office, 2)

      subject

      expect(json['offices'].count).to eq(3)
    end
  end

  describe '#create' do
    before { @office_attributes = attributes_for(:office) }

    subject do
      post "/api/v1/software_company/offices",
           params: { office: @office_attributes },
           headers: auth_header_for(account)
    end

    context 'with valid attributes' do
      it 'should create new office' do
        expect{ subject }.to change(Office, :count).by(1)
      end

      it "should respond with 200ok" do
        expect(subject.to_i).to eq(200)
      end

      it 'should return office id and info' do
        subject
        expect(json['office']['id']).to be_present
        expect(json['office']['country']).to eq(@office_attributes[:country])
      end
    end

    context 'with invalid attributes' do
      before { @office_attributes[:country] = '' }

      it 'should not create new office' do
        expect{ subject }.to change(Office, :count).by(0)
      end

      it "should respond with 200ok" do
        expect(subject.to_i).to eq(422)
      end

      it 'should return errors' do
        subject
        expect(json['errors']).to be_present
      end
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      subject do
        patch "/api/v1/software_company/offices/#{office.id}",
             params: { office: { city: 'Zumba' } },
             headers: auth_header_for(account)
      end

      it 'should update office' do
        subject
        expect(office.reload.city).to eq('Zumba')
      end

      it "should respond with 200ok" do
        expect(subject.to_i).to eq(200)
      end

      it 'should return office id and info' do
        subject
        expect(json['office']['id']).to be_present
        expect(json['office']['city']).to eq('Zumba')
      end
    end

    context 'with invalid attributes' do
      subject do
        patch "/api/v1/software_company/offices/#{office.id}",
             params: { office: { city: '' } },
             headers: auth_header_for(account)
      end

      it 'should not update office' do
        city = office.city
        subject
        expect(office.reload.city).to eq(city)
      end

      it "should respond with 422" do
        expect(subject.to_i).to eq(422)
      end

      it 'should return errors' do
        subject
        expect(json['errors']).to be_present
      end
    end

  end

  describe '#destroy' do
    subject do
      delete "/api/v1/software_company/offices/#{office.id}",
             headers: auth_header_for(account)
    end

    it 'should remove office' do
      office # creates office record
      expect{ subject }.to change(Office, :count).by(-1)
    end

    it "should respond with 200ok" do
      expect(subject.to_i).to eq(200)
    end
  end

end