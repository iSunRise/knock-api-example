class CreateSoftwareCompanyTechnologies < ActiveRecord::Migration[5.0]
  def change
    create_table :software_company_technologies do |t|
      t.integer :software_company_id, null: false
      t.integer :technology_id, null: false

      t.timestamps
    end

    add_index :software_company_technologies, [:software_company_id, :technology_id],
              unique: true, name: 'software_company_technologies_index'
  end
end
