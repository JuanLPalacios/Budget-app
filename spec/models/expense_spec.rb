require 'rails_helper'

RSpec.describe Expense, type: :model do
  context 'When creating a new expense:' do
    subject { Expense.create(author: User.first, name: 'expense 1', amount: 5) }
    before { subject.save }

    it 'Should validate name must not be blank.' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'Should validate amount must be greater or equal to 0.' do
      subject.amount = -1
      expect(subject).to_not be_valid
    end
  end
end
