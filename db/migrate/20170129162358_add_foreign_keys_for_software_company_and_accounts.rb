class AddForeignKeysForSoftwareCompanyAndAccounts < ActiveRecord::Migration[5.0]
  def change
    change_column :accounts, :software_company_id, :integer, null: false
    add_foreign_key :accounts, :software_companies
  end
end
