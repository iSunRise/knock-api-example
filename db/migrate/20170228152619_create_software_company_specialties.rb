class CreateSoftwareCompanySpecialties < ActiveRecord::Migration[5.0]
  def change
    create_table :software_company_specialties do |t|
      t.integer :software_company_id, null: false
      t.integer :specialty_id, null: false

      t.timestamps
    end

    add_index :software_company_specialties, [:software_company_id, :specialty_id],
              unique: true, name: 'software_company_specialties_index'
  end
end
