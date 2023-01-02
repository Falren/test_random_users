# frozen_string_literal: true

class Api::V1::RandomPeopleController < ApplicationController
  def show
    render json: User.random.first
  end
end
