# frozen_string_literal: true

class PopulateDb
  class ImportPeople
    include Interactor

    def call
      fetched_data = HTTParty.get(context.url)
      people = User.insert_all(formatted_people(fetched_data), returning: %w[id data])
      people = people.rows.map { |(id, data)| { id: id, data: JSON.parse(data) } }
      people_by_age = people.group_by { |person| person[:data]['dob']['age'] < User::PARENT_MIN_AGE ? :children : :adults }
      children = context.children_without_both_parents || User.where(id: people_by_age[:children].pluck(:id))
      adults_by_country = people_by_age[:adults].group_by { |adult| adult[:data]['nat'] }

      context.family = { children: children, adults: adults_by_country }
    end

    private

    def formatted_people(fetched_data)
      fetched_data.fetch('results', []).filter_map do |person|
        next if person['dob']['age'] <= User::PARENT_MIN_AGE && context.parents_only

        # no people under 20 years old in random user api
        { data: corrected_dob_person(person) }
      end
    end

    def corrected_dob_person(person)
      person['dob']['age'] < User::PARENT_MIN_AGE &&
        person['registered']['age'] < User::CHILD_MAX_AGE &&
        person.tap { |p| p['dob'] = person['registered'] } ||
        person
    end
  end
end
