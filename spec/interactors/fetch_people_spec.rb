# frozen_string_literal: true

require 'rails_helper'

describe PopulateDb::FetchPeople do
  let(:response) { instance_double(HTTParty::Response, body: response_body) }
  let(:params) { { url: 'https://randomuser.me/api/' } }
  subject { described_class.call(params) }

  before do
    allow(HTTParty).to receive(:get).and_return(response)
  end

  after {  expect(HTTParty).to have_received(:get).with(params[:url]) }

  describe '.call' do
    context 'with results' do
      let(:response_body) { create_list(:user, 5, :parent) }
      it 'fetches from api'  do
        expect(subject).to be_a_success
        expect(HTTParty).to have_received(:get).with(params[:url])
      end
    end
    context 'without results' do
      let(:response_body) { [] }
      it 'fetches from api' do
        expect(subject).to be_a_failure
        expect(HTTParty).to have_received(:get).with(params[:url])
        expect(subject.message).to eq('No result given')
      end
    end
  end
end
