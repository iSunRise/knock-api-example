class CreateTechnologies < ActiveRecord::Migration[5.0]
  def change
    create_table :technologies do |t|
      t.string :name, index: true, null: false

      t.timestamps
    end
  end
end
