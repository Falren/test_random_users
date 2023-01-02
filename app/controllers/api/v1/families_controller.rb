# frozen_string_literal: true

class Api::V1::FamiliesController < ApplicationController
  def show
    render json: User.find_by(id: params[:id]), include: %i[children parents]
  end
end
