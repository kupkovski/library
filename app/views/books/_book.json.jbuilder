json.extract! book, :id, :title, :author_name, :genre, :isbn, :total_copies, :created_at, :updated_at
json.url book_url(book, format: :json)
