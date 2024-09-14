require 'rails_helper'

RSpec.describe BorrowedBook, type: :model do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:due_date) }
  end

  describe 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end

  describe 'due_today' do
    let(:due_today) { BorrowedBook.create!(book:, user:, due_date: Date.today) }
    let(:due_tomorrow) { BorrowedBook.create!(book:, user:, due_date: Date.tomorrow) }

    context 'when record does not due today' do
      it 'should not be included on the list' do
        expect(BorrowedBook.due_today).to_not include(due_tomorrow)
      end
    end

    context 'when record does due today' do
      it 'should be included on the list' do
        expect(BorrowedBook.due_today).to include(due_today)
      end
    end
  end

  describe 'overdue' do
    let(:overdue) { BorrowedBook.create!(book:, user:, due_date: Date.yesterday) }
    let(:not_overdue) { BorrowedBook.create!(book:, user:, due_date: Date.tomorrow) }

    context 'when record is not overdue' do
      it 'should not be included on the list' do
        expect(BorrowedBook.overdue).to_not include(not_overdue)
      end
    end

    context 'when record is overdue' do
      it 'should be included on the list' do
        expect(BorrowedBook.overdue).to include(overdue)
      end
    end
  end
end
