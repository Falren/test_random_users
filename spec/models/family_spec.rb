require 'rails_helper'

RSpec.describe Family, type: :model do
  let!(:child_user1) { create(:user, :child) }
  let!(:children) { create_list(:user, 5, :child) }
  let!(:parent_user1) { create(:user, :parent) }
  let!(:parent_user2) { create(:user, :parent) }
  let!(:parent_user3) { create(:user, :parent) }

  context 'validates number of parents' do
    before { child_user1.parents = [parent_user1, parent_user2] }

    it_behaves_like 'a family validation', 'There can be only two parents'
  end

  context 'validates number of children' do
    before { parent_user3.children = children }
    it_behaves_like 'a family validation', 'Parent can have only up to 5 children'
  end

  context 'validates country of parents and children' do
    before { parent_user3.data['nat'] = 'NO' }

    it_behaves_like 'a family validation', 'Parents and children must be from the same country'
  end

  context 'validates age of parents' do
    before { parent_user3.data['dob']['age'] = 29 }

    it_behaves_like 'a family validation', 'Parent must be at least 30 years old'
  end
end
