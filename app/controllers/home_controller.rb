class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.member?
      @borrowed_books = current_user.borrowed_books
    end
  end
end
