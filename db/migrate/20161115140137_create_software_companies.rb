class CreateSoftwareCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :software_companies do |t|
      t.string :name,  null: false
      t.string :url_alias, index: true
      t.string :website
      t.text :about
      t.string :logo
      t.string :background_photo
      t.integer :number_of_employees
      t.text :contacts
      t.string :vat
      t.boolean :deleted, default: false
      t.boolean :listed, default: false

      t.timestamps
    end
  end
end
