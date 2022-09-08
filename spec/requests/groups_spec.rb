require 'rails_helper'

RSpec.describe '/groups', type: :request do
  include Warden::Test::Helpers

  before { login_as User.find(1), scope: :user }

  let(:valid_attributes) do
    { name: 'Test group', icon: Group::ICONS.first }
  end

  let(:invalid_attributes) do
    { name: '', icon: '' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get groups_path
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_group_path
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Group' do
        expect do
          post groups_path, params: { group: valid_attributes }
        end.to change(Group, :count).by(1)
      end

      it 'redirects back to /index' do
        post groups_path, params: { group: valid_attributes }
        expect(response).to redirect_to(groups_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Group' do
        expect do
          post groups_path, params: { group: invalid_attributes }
        end.to change(Group, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post groups_path, params: { group: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
