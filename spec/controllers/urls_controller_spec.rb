require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  let(:test_code) { 'test' }
  let!(:url) { create :url, url: 'https://booking.com/very-long-link-with-cool-places-selection', code: test_code }

  describe '#show' do
    it 'returns url' do
      get :show, params: { code: test_code }
      expect(response).to be_successful
    end
  end
end
