require 'rails_helper'

RSpec.describe SoftwareCompanyTechnology, type: :model do
  it { should respond_to(:software_company) }
  it { should respond_to(:technology) }

  it 'should validate uniquness software_company within technology' do
    company = FactoryGirl.create(:software_company)
    technology = FactoryGirl.create(:technology)
    SoftwareCompanyTechnology.create(software_company: company, technology: technology)
    sct = SoftwareCompanyTechnology.new(software_company: company, technology: technology)
    expect(sct).to be_invalid
  end
end
