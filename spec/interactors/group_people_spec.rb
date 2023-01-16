# frozen_string_literal: true

require 'rails_helper'

describe PopulateDb::GroupPeople do
  subject! { described_class.call(transformed_people_params: transformed_people_params) }
  let(:transformed_people_params) do
    create_list(:user, 5, :parent).concat(create_list(:user, 2, :child))
                                  .map(&:attributes)
                                  .map(&:symbolize_keys)
  end
  describe '.call' do
    it 'groups people by age' do
      expect(subject).to be_a_success
      expect(subject.people[:adults]).not_to be_nil
      expect(subject.people[:children]).not_to be_nil
    end
  end
end
