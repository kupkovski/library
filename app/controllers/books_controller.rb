require_relative "../services/book_borrower"
class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy borrow]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # PUT /books/1/borrow
  def borrow
    borrow_book = BookBorrower.call(book: @book, user: current_user)
    if borrow_book.valid?
      redirect_to book_url(@book), notice: "Book was successfully borrowed."
    else
      redirect_to book_url(@book), alert: borrow_book.errors.full_messages.join(",")
    end
  end

  # GET /search
  def search
    search_term = "%#{params[:q]}%"
    @books = Book.where("title like ? OR author_name like ? OR genre like ?", search_term, search_term, search_term)

    respond_to do |format|
      format.html { render :index }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author_name, :genre, :isbn, :total_copies)
    end
end
