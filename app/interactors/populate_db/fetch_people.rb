# frozen_string_literal: true

class PopulateDb
  class FetchPeople < BaseInteractor
    def call
      response = HTTParty.get(context.url)

      return context.fail!(message: 'No result given') if response.body.empty?

      context.fetched_people = response
    end
  end
end
