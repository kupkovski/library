class BookBorrower
  include ActiveModel::Validations

  validate :book_is_available?
  validate :book_already_borrowed_by_user?

  def initialize(book:, user:)
    @book = book
    @user = user
  end

  def self.call(book:, user:)
    new(book: book, user: user).call
  end

  def call
    return self unless valid?

    BorrowedBook.create(user: @user, book: @book, due_date: Date.current + 2.weeks)
  end

  private

  def book_already_borrowed_by_user?
    errors.add(:user, "Already borrowed this book") if @book.borrowed_by?(@user)
  end

  def book_is_available?
    errors.add(:book, "Is not available") unless @book.available?
  end
end
