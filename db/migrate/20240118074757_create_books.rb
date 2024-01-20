class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author_name, null: false
      t.string :isbn, null: false, unique: true
      t.string :genre, null: false
      t.integer :number_of_books, null: false, default: 0
      t.date :published_year, null: false
      t.string :image

      t.timestamps
    end
  end
end
