# frozen_string_literal: true

require 'rails_helper'

describe PopulateDb::InsertPeople do
  subject { described_class.call(fetched_people: { 'results' => fetched_people_params }) }
  let(:fetched_people_params) do
    build_list(:user, 5, :parent).map(&:data)
  end
  describe '.call' do
    it 'bulk inserts people' do
      expect { subject }.to change { User.count }.by(5)
      expect(subject).to be_a_success
    end
  end
end
