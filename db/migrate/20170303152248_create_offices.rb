class CreateOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :offices do |t|
      t.string :software_company_id, index: true
      t.integer :priority, index: true
      t.string :country, null: false
      t.string :city, null: false
      t.string :details
      t.string :phones, array: true, default: []
      t.string :emails, array: true, default: []
      t.jsonb :working_times, default: {}

      t.timestamps
    end
  end
end
