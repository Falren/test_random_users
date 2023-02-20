class GetPeople < BaseInteractor
  def call
    return context.fail!(error: "No #{context.generation} available in this country") if available_people.blank?

    context.people = available_people
  end

  private

  def available_people
    @available_people ||= User.public_send("filter_#{context.generation}_by_country", context.country)
  end
end
