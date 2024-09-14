# This will guess the Book class
FactoryBot.define do
  factory :book do
    title { "A Fake book" }
    author_name  { "Fake Author" }
    genre { "Fantasy" }
    isbn { "123123" }
    total_copies { 20 }
  end
end
