# frozen_string_literal: true

class Family < ActiveRecord::Base
  belongs_to :parent, foreign_key: :parent_id, class_name: 'User'
  belongs_to :child, foreign_key: :child_id, class_name: 'User'

  validates_with Validators::ParentValidator
  validates_with Validators::ParentAgeValidator
  validates_with Validators::ChildrenValidator
  validates_with Validators::CountryValidator
end
