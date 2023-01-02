# frozen_string_literal: true

require 'rails_helper'

describe GetPeopleByName do
  subject(:context) { described_class.call(name: user.data['name']['first']) }

  describe '.call' do
    context 'when user exists' do
      let(:user) { create(:user, :parent) }
      it 'succeeds' do
        expect(context).to be_a_success
      end
    end
    context 'when name has not been provided' do
      let(:user) { create(:user, data: { name: {} }) }
      it 'fails' do
        expect(context.error).to eq('No name has been specified')
        expect(context).to be_a_failure
      end
    end
    context 'when name has no matches' do
      let(:user) { build(:user, data: { name: { first: 'name' } }) }
      it 'fails' do
        expect(context.error).to eq('No people with such name were found')
        expect(context).to be_a_failure
      end
    end
  end
end
