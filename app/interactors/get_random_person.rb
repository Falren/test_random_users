class GetRandomPerson < BaseInteractor
  def call
    return context.fail!(error: 'No person was found') unless random_person

    context.random_person = random_person
  end

  private

  def random_person
    @random_person ||= User.random.first
  end
end
