# frozen_string_literal: true

class Validators::ParentValidator < ActiveModel::Validator
  def validate(record)
    return if Family.where(child: record.child).size < 2

    record.errors.add(:parent_id, 'There can be only two parents')
  end
end
