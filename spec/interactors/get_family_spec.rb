# frozen_string_literal: true

require 'rails_helper'

describe GetFamily do
  subject(:context) { described_class.call(id: user.id) }

  describe '.call' do
    it_behaves_like 'user'
  end
end
