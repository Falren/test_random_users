# frozen_string_literal: true

class Api::V1::RandomPeopleController < ApplicationController
  def show
    return render json: random_person if random_person

    render json: { error: 'No parents in this country' }, status: :not_found
  end

  private

  def random_person
    @random_person ||= User.random.first
  end
end
