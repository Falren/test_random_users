# frozen_string_literal: true

shared_examples_for 'a family validation' do |message|
  it 'shows matches validation message' do
    subject = build(:family, child: child_user1, parent: parent_user3)
    subject.validate
    expect(subject.errors[:parent_id]).to include(message)
  end
end
