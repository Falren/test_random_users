require 'rails_helper'

RSpec.describe '/children', type: :request do
  describe 'GET /index' do
    context 'with country' do
      let!(:parents) { create_list(:user, 5, :parent) }
      it 'renders a successful response' do
        get api_v1_parents_path(country: 'US')
        response_body = JSON.parse(response.body)
        expect(response_body.count).to eq(5)
        expect(response.status).to eq(200)
      end
    end
    context 'with unavailable country' do
      it_behaves_like 'a failed response', {
        message: 'No parents available in this country',
        url: '/api/v1/parents?country=UA'
      }
    end
  end
end
