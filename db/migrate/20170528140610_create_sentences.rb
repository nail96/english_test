class CreateSentences < ActiveRecord::Migration[5.0]
  def change
    create_table :sentences do |t|
      t.text :text
      t.boolean :has_specific_answer
      t.belongs_to :exercise, foreign_key: true

      t.timestamps
    end
  end
end
