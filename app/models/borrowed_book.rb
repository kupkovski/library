class BorrowedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def due_date
    return nil if created_at.blank?

    created_at + 2.weeks
  end
end
