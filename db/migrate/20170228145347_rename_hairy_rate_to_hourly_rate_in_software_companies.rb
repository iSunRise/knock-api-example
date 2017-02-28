class RenameHairyRateToHourlyRateInSoftwareCompanies < ActiveRecord::Migration[5.0]
  def change
    rename_column :software_companies, :average_hairly_rate, :average_hourly_rate
  end
end
