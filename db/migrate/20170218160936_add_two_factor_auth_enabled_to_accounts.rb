class AddTwoFactorAuthEnabledToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :two_factor_auth_enabled, :boolean, default: false
  end
end
