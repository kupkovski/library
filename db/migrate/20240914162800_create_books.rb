class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author_name
      t.string :genre
      t.string :isbn
      t.integer :total_copies

      t.timestamps
    end
  end
end
