# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('users/index')
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('users/new')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: FactoryBot.attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the users index page' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: { invalid: 'parameters' } }
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: { invalid: 'parameters' } }
        expect(response).to render_template('users/new')
      end
    end
  end
end
