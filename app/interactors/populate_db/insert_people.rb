class PopulateDb
  class InsertPeople < BaseInteractor

    def call
      corrected_children_dob_people = correct_children_dob
      people_params = User.insert_all(corrected_children_dob_people, returning: %w[id data])
      context.transformed_people_params = transform_people_params(people_params)
    end

    private

    def transform_people_params(people_params)
      people_params.rows.map do |(id, data)|
        {
          id: id,
          data: JSON.parse(data)
        }
      end
    end

    def correct_children_dob
      context.fetched_people['results'].filter_map do |person|
        { data: transform_person_dob(person) } unless child_passable(person)
      end
    end

    def child_passable(person)
      person['dob']['age'] <= User::PARENT_MIN_AGE && context.need_parents_only
    end

    def transform_person_dob(person)
      return person if person['dob']['age'] > User::PARENT_MIN_AGE

      return person if person['registered']['age'] > User::CHILD_MAX_AGE

      person.tap { |p| p['dob'] = person['registered'] }
    end
  end
end
