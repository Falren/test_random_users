# frozen_string_literal: true

require 'rails_helper'

describe GetPeople do
  subject(:context) { described_class.call(country: country, generation: generation) }
  let(:country) { 'US' }

  describe '.call' do
    context 'when get parents' do
      let(:generation) { 'parents' }

      context 'when parents available' do
        let!(:parents) { create_list(:user, 5, :parent) }
        it 'succeeds' do
          expect(context).to be_a_success
        end
      end
      context 'when parents unavailable' do
        it 'fails' do
          expect(context.error).to eq('No parents available in this country')
          expect(context).to be_a_failure
        end
      end
    end
    context 'when get children' do
      let(:generation) { 'children' }

      context 'when children available' do
        let!(:children) { create_list(:user, 5, :child) }
        it 'succeeds' do
          expect(context).to be_a_success
        end
      end
      context 'when children unavailable' do
        it 'fails' do
          expect(context.error).to eq('No children available in this country')
          expect(context).to be_a_failure
        end
      end
    end
  end
end
