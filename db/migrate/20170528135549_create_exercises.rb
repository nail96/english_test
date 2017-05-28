class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.string :title
      t.belongs_to :unit, foreign_key: true

      t.timestamps
    end
  end
end
