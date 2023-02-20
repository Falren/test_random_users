class Api::V1::RandomPeopleController < ApplicationController
  def show
    result = GetRandomPerson.call
    return render json: { error: result.error }, status: :not_found if result.failure?

    render json: result.random_person
  end
end
