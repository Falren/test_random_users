# frozen_string_literal: true

shared_examples_for 'a failed response' do |params|
  it 'it fails with message' do
    get params[:url], as: :json

    expect(response.body).to match(a_string_including(params[:message]))
    expect(response.status).to eq(404)
    expect(response.content_type).to match(a_string_including('application/json'))
  end
end
