require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it { should have_many(:borrowed_books) }
    let(:book) { create(:book, total_copies: 2) }
    let(:user) { create(:user) }

    describe 'available' do
      context 'when there are copies not borrowed yet' do
        let(:user) { create(:user) }
        let!(:borrowed_book) { create(:borrowed_book, book:, user:) }

        it 'returns true' do
          expect(BorrowedBook.where(book:).count).to eq 1
          expect(book).to be_available
        end
      end

      context 'when all copies were borrowed' do
        let!(:borrowed_book) { create(:borrowed_book, book:, user:) }
        let!(:borrowed_book2) { create(:borrowed_book, book:, user:) }

        it 'returns false' do
          expect(BorrowedBook.where(book:).count).to eq 2
          expect(book).to_not be_available
        end
      end
    end

    describe 'borrowed_by?' do
      context 'when user borrowed the book' do
        it 'returns false' do
          expect(BorrowedBook.where(user: user, book: book).exists?).to be false
          expect(book.borrowed_by?(user)).to be false
        end
      end

      context 'when user did not borrowed the book' do
        let!(:borrowed_book) { create(:borrowed_book, book:, user:) }

        it 'returns true' do
          expect(book.borrowed_by?(user)).to be true
        end
      end
    end
  end
end
