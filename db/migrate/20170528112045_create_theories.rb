class CreateTheories < ActiveRecord::Migration[5.0]
  def change
    create_table :theories do |t|
      t.string :image
      t.string :links

      t.timestamps
    end
  end
end
