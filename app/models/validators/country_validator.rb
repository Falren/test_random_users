# frozen_string_literal: true

class Validators::CountryValidator < ActiveModel::Validator
  def validate(record)
    return if record.parent&.data['nat'] == record.child&.data['nat']

    record.errors.add(:parent_id, 'Parents and children must be from the same country')
  end
end
