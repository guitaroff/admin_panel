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
end
