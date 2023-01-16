# frozen_string_literal: true

class PopulateDb
  class GroupPeople < BaseInteractor
    def call
      people_grouped_by_age = group_people_by_age

      context.people = {
        adults: adults_grouped_by_country(people_grouped_by_age),
        children: children_need_parents(people_grouped_by_age)
      }
    end

    private

    def group_people_by_age
      context.transformed_people_params.group_by do |person|
        next :children if person[:data]['dob']['age'] < User::PARENT_MIN_AGE

        :adults
      end
    end

    def adults_grouped_by_country(people_grouped_by_age)
      people_grouped_by_age[:adults].group_by { |adult| adult[:data]['nat'] }
    end

    def children_need_parents(people_grouped_by_age)
      return context.children_without_both_parents if context.children_without_both_parents.present?

      User.where(id: people_grouped_by_age[:children].pluck(:id))
    end
  end
end
