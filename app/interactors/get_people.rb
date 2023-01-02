# frozen_string_literal: true

class GetPeople
  include Interactor

  def call
    return context.fail!(error: 'This country is not available') unless country_available

    return context.fail!(error: "No #{context.generation} available in this country") unless available_people

    context.people = available_people
  end

  private

  def available_people
    @available_people ||= User.public_send("filter_#{context.generation}_by_country", context.country)
  end

  def country_available
    @country_available ||= available_people.pluck(Arel.sql("(data->'nat')")).uniq.include?(context.country.upcase)
  end
end
