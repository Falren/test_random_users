# frozen_string_literal: true

class PopulateDb
  class CreateRelationships < BaseInteractor
    def call
      create_family
      context.children_without_both_parents = children_without_both_parents
      return if children_without_both_parents.present?

      context.fail!(message: 'DB population completed')
    end

    private

    def create_family
      context.people[:children].each do |child|
        next if context.people[:adults][child.data['nat']].blank?

        adult_couple = take_adult_couple_by_country(child.data['nat'])
        child.parent_ids = adult_couple.pluck(:id)
      end
    end

    def children_without_both_parents
      context.people[:children].without_both_parents
    end

    def take_adult_couple_by_country(country)
      context.people[:adults][country].slice!(0..1)
    end
  end
end
