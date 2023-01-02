class Api::V1::ParentsController < ApplicationController
  def index
    result = GetPeople.call(country: params[:country], generation: 'parents')
    return render json: { error: result.error }, status: :not_found if result.failure?

    render json: result.people
  end
end
