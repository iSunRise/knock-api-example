class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :position
      t.string :email,           null: false
      t.string :password_digest, null: false
      t.string :roles, array: true, default: []
      t.string :photo
      t.integer :software_company_id, index: true

      t.timestamps
    end
  end
end
