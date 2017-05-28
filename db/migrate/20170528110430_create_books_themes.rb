class CreateBooksThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :books_themes, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :theme, index: true
    end
  end
end
