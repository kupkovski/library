class Book < ApplicationRecord
  has_many :borrowed_books

  validates :title, :author_name, :genre, :isbn, :total_copies, presence: true

  def available?
    borrowed_books.count < total_copies
  end

  def borrowed_by?(user)
    borrowed_books.where(user: user).exists?
  end

  def borrow!(user:)
    borrowed = borrowed_books.build(user:, due_date: Date.current + 2.weeks)
    borrowed.save!
  end
end
