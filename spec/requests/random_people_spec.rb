require 'rails_helper'

RSpec.describe '/random_person', type: :request do
  describe 'GET /show' do
    context 'when people exist' do
      let!(:person) { create(:user, :child) }
      it 'renders a successful response' do
        get api_v1_random_person_path, as: :json
        expect(response.status).to eq(200)
      end
    end
    context 'when people do not exist' do
      it 'renders a successful response' do
        get api_v1_random_person_path, as: :json
        expect(response.body).to match(a_string_including('No person was found'))
        expect(response.status).to eq(404)
      end
    end
  end
end

