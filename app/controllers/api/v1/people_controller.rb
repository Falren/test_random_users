# frozen_string_literal: true

class Api::V1::PeopleController < ApplicationController
  def index
    result = GetPeopleByName.call(name: params[:name])
    return render json: result.people if result.success?

    render json: result.error, status: :not_found
  end
end
