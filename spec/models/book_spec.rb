require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it { should have_many(:borrowed_books) }

    describe 'available' do
      context 'when there are copies not borrowed yet' do
        let(:book) { create(:book, total_copies: 2) }
        let(:user) { create(:user) }
        let!(:borrowed_book) { create(:borrowed_book, book:, user:) }

        it 'returns true' do
          expect(BorrowedBook.where(book:).count).to eq 1
          expect(book).to be_available
        end
      end

      context 'when all copies were borrowed' do
        let(:book) { create(:book, total_copies: 2) }
        let(:user) { create(:user) }
        let!(:borrowed_book) { create(:borrowed_book, book:, user:) }
        let!(:borrowed_book2) { create(:borrowed_book, book:, user:) }

        it 'returns false' do
          expect(BorrowedBook.where(book:).count).to eq 2
          expect(book).to_not be_available
        end
      end
    end
  end
end
