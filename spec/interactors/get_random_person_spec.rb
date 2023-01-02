# frozen_string_literal: true

require 'rails_helper'

describe GetRandomPerson do
  subject(:context) { described_class.call }

  describe '.call' do
    it_behaves_like 'user'
  end
end
