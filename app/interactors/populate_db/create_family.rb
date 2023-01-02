# frozen_string_literal: true

class PopulateDb
  class CreateFamily
    include Interactor

    def call
      context.family[:children].each do |child|
        next if context.family[:adults][child.data['nat']].blank?

        create_family(child)
      end
      context.family = context.family[:children].without_both_parents
    end

    private

    attr_reader :params

    def create_family(child)
      parent_ids = context.family[:adults][child.data['nat']].slice!(0..1).pluck(:id)
      child.parent_ids = parent_ids
    end
  end
end
