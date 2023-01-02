# frozen_string_literal: true

class PeopleImportService
  CHILDREN_AGE = 20
  PARENTS_AGE = 30
  def initialize(params)
    @params = params
  end

  def call
    fetched_data = HTTParty.get(params[:url])
    people = User.insert_all(formatted_people(fetched_data), returning: %w[id data])
    people = people.rows.map { |(id, data)| { id: id, data: JSON.parse(data) } }
    people_by_age = people.group_by { |person| person[:data]['dob']['age'] < PARENTS_AGE ? :children : :adults }
    children = params[:children_without_both_parents] || User.where(id: people_by_age[:children].pluck(:id))
    adults_by_country = people_by_age[:adults].group_by { |adult| adult[:data]['nat'] }

    CreateFamilyService.new(children: children, adults: adults_by_country).call
    children.without_both_parents
  end

  private

  attr_reader :params

  def formatted_people(fetched_data)
    fetched_data.fetch('results', []).filter_map do |person|
      next if person['dob']['age'] <= PARENTS_AGE && params[:parents_only]

      # no people under 20 years old in random user api 
      { data: corrected_dob_person(person) }
    end
  end

  def corrected_dob_person(person)
    person['dob']['age'] < PARENTS_AGE &&
      person['registered']['age'] < CHILDREN_AGE &&
      person.tap { |p| p['dob'] = person['registered'] } ||
      person
  end
end
