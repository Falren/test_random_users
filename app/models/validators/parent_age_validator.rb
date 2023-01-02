# frozen_string_literal: true

class Validators::ParentAgeValidator < ActiveModel::Validator
  def validate(record)
    return if record.parent.data['dob']['age'] >= User::PARENT_MIN_AGE

    record.errors.add(:parent_id, 'Parent must be at least 30 years old')
  end
end
