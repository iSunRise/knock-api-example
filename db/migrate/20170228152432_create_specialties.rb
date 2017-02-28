class CreateSpecialties < ActiveRecord::Migration[5.0]
  def change
    create_table :specialties do |t|
      t.string   "name",  null: false
      t.string   "token", null: false

      t.timestamps
    end

    add_index :specialties, :token, unique: true
  end
end
