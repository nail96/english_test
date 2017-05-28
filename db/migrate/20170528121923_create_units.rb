class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :title
      t.integer :number
      t.belongs_to :theory, foreign_key: true
      t.belongs_to :theme, foreign_key: true

      t.timestamps
    end
  end
end
