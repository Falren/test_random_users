require 'rails_helper'

RSpec.describe '/children', type: :request do
  describe 'GET /index' do
    context 'with country' do
      let!(:children) { create_list(:user, 5, :child) }
      it 'renders a successful response' do
        get api_v1_children_path(country: 'US')
        response_body = JSON.parse(response.body)
        expect(response_body.count).to eq(5)
        expect(response.status).to eq(200)
      end
    end
    context 'with unavailable country' do
      it_behaves_like 'a failed response', {
        message: 'No children available in this country',
        url: '/api/v1/children?country=UA'
      }
    end
  end
end
