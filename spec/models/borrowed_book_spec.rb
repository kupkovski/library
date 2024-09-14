require 'rails_helper'

RSpec.describe BorrowedBook, type: :model do
  describe 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end

  describe 'due_date' do
    context 'for new records' do
      subject { BorrowedBook.new(created_at: nil) }
      it 'returns nil' do
        expect(subject.due_date).to be_nil
      end
    end

    context 'for existing records' do
      let(:user) { create(:user) }

      subject { BorrowedBook.create!(book: Book.create!, user: user) }
      it 'returns nil' do
        expect(subject.due_date.to_date).to eq((subject.created_at + 2.weeks).to_date)
      end
    end
  end
end
