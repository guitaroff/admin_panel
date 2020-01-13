require 'rails_helper'

RSpec.describe 'Account API' do
  let!(:account) { create(:user, api: true) }

  describe 'GET /api/v1/account' do
    context 'when the user is valid' do
      before do
        get '/api/v1/account', {
          params: {
            user_email: account.email,
            user_token: account.authentication_token
          }
        }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the current account' do
        expect(json).not_to be_empty
        expect(json['email']).to eq(account.email)
      end
    end

    context 'when the user is not valid' do
      before do
        get '/api/v1/account', {
          params: {
            user_email: account.email,
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

  describe 'PATCH /api/v1/account' do
    context 'when the account was successfully updated' do
      before do
        patch '/api/v1/account', {
          params: {
            user_email: account.email,
            user_token: account.authentication_token,
            user: {
              name: 'Роджер'
            }
          }
        }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the account with new name' do
        expect(json['name']).to eq('Роджер')
      end
    end

    context 'account update error' do
      before do
        patch '/api/v1/account', {
          params: {
            user_email: account.email,
            user_token: 'token',
            user: {
              name: 'Роджер'
            }
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
