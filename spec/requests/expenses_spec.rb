require 'rails_helper'

RSpec.describe '/groups/:group_id/expenses', type: :request do
  include Warden::Test::Helpers

  before { login_as User.find(1), scope: :user }

  let(:valid_attributes) do
    { name: 'expense 1', amount: 5, groups: [1] }
  end

  let(:invalid_attributes) do
    { name: '', amount: -1, groups: [] }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get group_expenses_path(1)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_group_expense_path(1)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Expense' do
        expect do
          post group_expenses_path(1), params: { expense: valid_attributes }
        end.to change(Expense, :count).by(1)
      end

      it 'redirects to back to /index' do
        post group_expenses_path(1), params: { expense: valid_attributes }
        expect(response).to redirect_to(group_expenses_path(1))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Expense' do
        expect do
          post group_expenses_path(1), params: { expense: invalid_attributes }
        end.to change(Expense, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post group_expenses_path(1), params: { expense: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
