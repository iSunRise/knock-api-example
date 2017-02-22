class AddMissingFieldsToSoftwareCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :software_companies, :foundation_date, :date
    add_column :software_companies, :average_hairly_rate, :integer
    add_column :software_companies, :minimum_project_size, :integer
  end
end
