class AddTokenToTechnologies < ActiveRecord::Migration[5.0]
  def change
    remove_index :technologies, :name
    add_column :technologies, :token, :string,  null: false
    add_index :technologies, :token, unique: true
  end
end
