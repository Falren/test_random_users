# frozen_string_literal: true

shared_examples_for 'user' do
  context 'when user exists' do
    let!(:user) { create(:user) }
    it 'succeeds' do
      expect(context).to be_a_success
    end
  end
  context 'when user does not exist' do
    let(:user) { build(:user) }
    it 'fails' do
      expect(context.error).to eq('No person was found')
      expect(context).to be_a_failure
    end
  end
end
