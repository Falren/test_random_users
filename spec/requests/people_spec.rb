# frozen_string_literal: true

require 'rails_helper'

describe '/people', type: :request do
  describe 'GET /index' do
    context 'with name in params' do
      let!(:person) { create(:user, :parent) }
      let(:person_name) { person.data['name']['first'] }
      it 'renders a successful response' do
        get "#{api_v1_people_path}/?name=#{person_name}"
        expect(response.body).to match(a_string_including(person_name))
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
    context 'without name in params' do
      it_behaves_like 'a failed response', { message: 'No name has been specified', url: '/api/v1/people' }
    end
    context 'person does not exist' do
      it_behaves_like 'a failed response', {
        message: 'No people with such name were found',
        url: "/api/v1/people/?name='random_name'"
      }
    end
  end
end
