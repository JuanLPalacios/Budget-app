require 'rails_helper'

RSpec.describe User, type: :model do
  context 'When creating a new user:' do
    subject do
      User.create(name: 'Test', email: 'b@gmail.com', password: '111111', password_confirmation: '111111',
                  confirmed_at: DateTime.now)
    end
    before { subject.save }

    it 'Should validate name must not be blank.' do
      subject.name = ''
      expect(subject).to_not be_valid
    end
  end
end
