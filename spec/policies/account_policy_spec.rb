require 'rails_helper'

RSpec.describe AccountPolicy do
  subject { AccountPolicy }
  let(:account) { FactoryGirl.create(:account) }

  permissions :show?, :update?, :destroy? do
    it 'allows access to own account' do
      expect(subject).to permit(account, account)
    end

    it 'denies access for other users' do
      expect(subject).not_to permit(account, FactoryGirl.create(:account))
    end
  end

  permissions :create? do
    it 'allows to create account' do
      expect(subject).to permit(nil, nil)
    end
  end
end
