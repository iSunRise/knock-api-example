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
end
