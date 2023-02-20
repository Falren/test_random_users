class GetPeopleByName < BaseInteractor
  def call
    return context.fail!(error: 'No name has been specified') if context.name.blank?

    return context.fail!(error: 'No people with such name were found') if people.blank?

    context.people = people
  end

  private

  def people
    @people ||= User.filter_by_name(context.name.downcase)
  end
end
