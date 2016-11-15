require 'rails_helper'

RSpec.describe Account, type: :model do
  [:first_name,
   :last_name,
   :middle_name,
   :position,
   :email,
   :password,
   :password_confirmation,
   :roles,
   :photo,
   :software_company_id].each do |field|
    it { should respond_to(field) }
  end

  it 'has valid factory' do
    expect(FactoryGirl.build(:account)).to be_valid
  end

  [:email, :password_digest, :first_name, :last_name].each do |field|
    it { expect(FactoryGirl.build(:account, field => nil)).to be_invalid }
  end

  it 'must contain software_company_name on creation' do
    account = FactoryGirl.build(:account, software_company_name: nil)
    expect(account).to be_invalid
  end

  it 'should not contain software_company_name on save' do
    account = FactoryGirl.create(:account)
    account.software_company_name = nil
    expect(account).to be_valid
  end
end
