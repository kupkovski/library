class BorrowedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :due_date, presence: true

  scope :due_today, -> { where("date(due_date) = ?", Date.current) }
  scope :overdue, ->   { where("date(due_date) <= ?", Date.current) }
end
