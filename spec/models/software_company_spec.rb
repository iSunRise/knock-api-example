require 'rails_helper'

RSpec.describe SoftwareCompany, type: :model do
  [:name,
   :url_alias,
   :website,
   :about,
   :logo,
   :background_photo,
   :number_of_employees,
   :contacts,
   :vat,
   :deleted,
   :listed].each do |field|
    it { should respond_to(field) }
  end

  it 'should have valid factory' do
    expect(FactoryGirl.build(:software_company)).to be_valid
  end

  it { expect(FactoryGirl.build(:software_company, name: nil)).to be_invalid }
end
