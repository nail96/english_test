class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :text
      t.belongs_to :sentence, foreign_key: true

      t.timestamps
    end
  end
end
