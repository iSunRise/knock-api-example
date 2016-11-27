require 'rails_helper'

RSpec.describe SoftwareCompanyPolicy do
  subject { SoftwareCompanyPolicy }
  let(:company) { FactoryGirl.create(:software_company) }
  let(:account) { FactoryGirl.create(:account, software_company: company) }

  permissions :show? do
    it 'allows access to all if company listed' do
      company.update_columns(listed: true)
      expect(subject).to permit(nil, company)
    end

    it 'denies access for not owners if company is not listed' do
      company.update_columns(listed: false)
      expect(subject).not_to permit(FactoryGirl.create(:account), company)
    end

    it 'allows access for owners if company is not listed' do
      company.update_columns(listed: false)
      expect(subject).to permit(account, company)
    end
  end

  permissions :update? do
    it 'allows to update for company account' do
      expect(subject).to permit(account, company)
    end

    it 'denies to update for other accounts' do
      expect(subject).not_to permit(FactoryGirl.create(:account), company)
    end
  end
end
