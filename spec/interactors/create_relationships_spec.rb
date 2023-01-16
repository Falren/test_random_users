# frozen_string_literal: true

require 'rails_helper'

describe PopulateDb::CreateRelationships do
  subject(:context) { described_class.call(people: { children: children, adults: parents }) }
  let(:parents) do
    create_list(:user, 5, :parent)
      .map(&:attributes)
      .map(&:symbolize_keys)
      .group_by { |adult| adult[:data]['nat'] }
  end

  describe '.call' do
    context 'without parents' do
      let(:children) { User.where(id: create_list(:user, 5, :child)) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end

    context 'with parents' do
      let(:children) { User.where(id: create(:user, :child)) }

      it 'fails' do
        expect(context).to be_a_failure
      end
    end
  end
end
