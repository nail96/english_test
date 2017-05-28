class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email_address, null: false

      t.timestamps null: false
    end
    add_index :users, :email_address, unique: true
  end
end
