# frozen_string_literal: true

class Validators::ChildrenValidator < ActiveModel::Validator
  def validate(record)
    return if Family.where(parent: record.parent).size < User::MAX_NUMBER_OF_CHILDREN

    record.errors.add(:parent_id, 'Parent can have only up to 5 children')
  end
end
