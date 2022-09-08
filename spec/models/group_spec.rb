require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'When creating a new group:' do
    subject { Group.new(user: User.first, name: 'Test group', icon: Group::ICONS.first) }
    before { subject.save }

    it 'Should validate name must not be blank.' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'Should validate icon must not be blank.' do
      subject.icon = ''
      expect(subject).to_not be_valid
    end

    it 'Should validate icon must be one of options in Group::ICONS.' do
      subject.icon = 'invalid option'
      expect(subject).to_not be_valid
    end
  end

  context 'Given a group group:' do
    before(:all) { @user = User.first }
    subject { Group.create(user: @user, name: 'Test group', icon: Group::ICONS.first) }

    it 'Should calculate the total of the grop expenses' do
      subject.expenses.push Expense.create(author: @user, name: 'expense 1', amount: 5)
      subject.expenses.push Expense.create(author: @user, name: 'expense 2', amount: 7)
      subject.expenses.push Expense.create(author: @user, name: 'expense 3', amount: 9)

      total = subject.total

      expect(total).to eq(21)
    end
  end
end
