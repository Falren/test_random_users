require 'rails_helper'

RSpec.describe '/families', type: :request do
  describe 'GET /show' do
    let(:person) { create(:user, :parent) }
    context 'when person exists' do
      it 'renders a successful response' do
        get api_v1_family_path(id: person.id), as: :json
        expect(response.status).to eq(200)
        expect(response.body).to match(a_string_including(person.id.to_s))
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
    context 'when person does not exist' do
      it 'renders a failed response' do
        get api_v1_family_path(id: 1), as: :json
        expect(response.status).to eq(404)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
