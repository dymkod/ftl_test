require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  let(:user) { create :user }
  let(:user_access_token) { JsonWebToken.encode(user_id: user.id) }


  describe '#login' do
    context 'user exists' do
      it 'responds with auth token' do
        get :login, params: { email: user.email }

        expect(JSON.parse(response.body)['token']).to eq(user_access_token)
      end
    end

    context 'user not exist' do
      it 'responds with 404 status' do
        get :login, params: { email: 'invalid@email.duh' }

        expect(response.status).to be(404)
      end
    end
  end
end
