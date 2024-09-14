# This will guess the Book class
FactoryBot.define do
  factory :borrowed_book do
    book
    user
    due_date { Date.tomorrow }
  end
end
