class CreateBorrowedBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :borrowed_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime   :due_date

      t.timestamps
    end
  end
end
