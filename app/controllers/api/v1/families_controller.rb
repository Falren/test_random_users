# frozen_string_literal: true

class Api::V1::FamiliesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {
      error: e.message
    }, status: :not_found
  end

  def show
    render json: User.find(params[:id]), include: %i[children parents]
  end
end
