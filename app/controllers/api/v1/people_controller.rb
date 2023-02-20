class Api::V1::PeopleController < ApplicationController
  def index
    result = GetPeopleByName.call(name: params[:name])
    return render json: result.people if result.success?

    render json: { error: result.error }, status: :not_found
  end
end
