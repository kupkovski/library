require 'rails_helper'

RSpec.describe BookBorrower do
  let(:user) { create(:user, user_type: 'member') }
  let(:another_user) { create(:user, user_type: 'member', name: 'different user', email: 'different@email.com') }
  let(:book) { create(:book, total_copies: total_copies) }

  describe 'call' do
    context 'when book is no longer available' do
      let!(:borrowed_book) { create(:borrowed_book, book:, user:) }
      let(:total_copies) { 1 }

      it 'adds error and does not create the BorrowedBook record' do
        expect do
          borrower = BookBorrower.call(book:, user:)
          expect(borrower.errors[:book]).to eq [ 'Is not available' ]
        end.to_not change { BorrowedBook.count }
      end
    end

    context 'when user already borrowed this book' do
      let(:total_copies) { 3 }
      let!(:borrowed_book) { create(:borrowed_book, book:, user:) }

      it 'adds error and does not create the BorrowedBook record' do
        expect do
          borrower = BookBorrower.call(book:, user:)
          expect(borrower.errors[:user]).to eq [ 'Already borrowed this book' ]
        end.to_not change { BorrowedBook.count }
      end
    end

    context 'when user can borrow' do
      let(:total_copies) { 3 }
      let!(:borrowed_book) { create(:borrowed_book, book:, user: another_user) }
      let(:book) { create(:book, title: 'Please Borrow', total_copies:) }

      it 'adds error and does not create the BorrowedBook record' do
        expect do
          borrower = BookBorrower.call(book:, user:)
          expect(borrower).to be_valid
        end.to change { BorrowedBook.count }.by(1)
        borrowed = BorrowedBook.last
        expect(borrowed.book).to eq book
        expect(borrowed.user).to eq user
      end
    end
  end
end
