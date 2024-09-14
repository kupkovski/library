class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.librarian?
      @borrowed_books = BorrowedBook.all
      @books_count = Book.count
      @members_with_overdue_books = BorrowedBook.overdue
      @books_due_today_count = BorrowedBook.due_today.count
    else
      @borrowed_books = current_user.borrowed_books
    end
  end
end
