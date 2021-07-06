require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  let(:test_code) { 'test' }
  let(:test_url) { 'https://booking.com/very-long-link-with-cool-places-selection' }
  let(:user) { create :user }
  let(:url) { create :url, url: test_url, code: test_code }

  describe '#show' do
    context 'code is valid' do
      it 'returns url' do
        url
        get :show, params: { code: test_code }
        expect(response).to be_successful
      end
    end

    context 'code is invalid' do
      it 'resturns 500 status' do
        url
        get :show, params: { code: 'wrong_code' }
        expect(response).not_to be_successful
      end
    end
  end

  describe '#create' do
    context 'user authorized' do
      it 'creates code' do
        token = JsonWebToken.encode(user_id: user.id)
        request.headers['Authorization'] = "Bearer: #{token}"

        expect {
          post :create, params: { url: test_url }
        }.to change{ Url.count }.from(0).to(1)
      end
    end

    context 'user not authorized' do
      it 'does not create a code' do
        token = 'invalid token'
        request.headers['Authorization'] = "Bearer: #{token}"

        expect {
          post :create, params: { url: test_url }
        }.not_to change{ Url.count }
      end
    end
  end
end
