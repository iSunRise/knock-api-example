class CreatePhoneVerifications < ActiveRecord::Migration[5.0]
  def change
    create_table :phone_verifications do |t|
      t.string :phone_number, index: true, null: false
      t.string :pin_token
      t.integer :attempts, default: 0
      t.boolean :matched, default: false

      t.timestamps
    end
  end
end
