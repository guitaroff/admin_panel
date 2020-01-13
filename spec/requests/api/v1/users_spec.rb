require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'POST /api/v1/users' do
    let(:valid_attributes) { { user: { email: 'ex1@example.com', password: '123456', password_confirmation: '123456' } } }

    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['email']).to eq('ex1@example.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/users', params: { user: { email: 'IsNotValidEmail', password: nil } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        errors = json['data']['errors']

        expect(errors['email'].first).to eq('неверный формат')
        expect(errors['password'].first).to eq('не может быть пустым')
      end
    end
  end

  describe 'GET /api/v1/users' do
    let!(:users) { create_list(:user, 10, api: true) }
    let!(:current_user) { users.first }

    context 'when the current user is valid' do
      before do
        get '/api/v1/users', {
          params: {
            user_email: current_user.email,
            user_token: current_user.authentication_token
          }
        }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return users' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
    end

    context 'when the current user is not valid' do
      before do
        get '/api/v1/users', {
          params: {
            user_email: current_user.email,
            user_token: 'token'
          }
        }
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'user unauthorized message' do
        expect(json['error']).to eq 'Вам необходимо войти в систему или зарегистрироваться.'
      end
    end
  end

  describe 'GET /api/v1/users/:id' do
    let!(:users) { create_list(:user, 2, api: true) }
    let!(:current_user) { users.first }

    context 'when the current user is valid' do
      before do
        get "/api/v1/users/#{users.second.id}", {
          params: {
            user_email: current_user.email,
            user_token: current_user.authentication_token
          }
        }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the user' do
        expect(json).not_to be_empty
        expect(json['email']).to eq(users.second.email)
      end
    end

    context 'when the current user is not valid' do
      before do
        get "/api/v1/users/#{users.second.id}", {
          params: {
            user_email: current_user.email,
            user_token: 'token'
          }
        }
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'user unauthorized message' do
        expect(json['error']).to eq 'Вам необходимо войти в систему или зарегистрироваться.'
      end
    end
  end
end
