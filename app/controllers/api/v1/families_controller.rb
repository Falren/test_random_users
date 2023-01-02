# frozen_string_literal: true

class Api::V1::FamiliesController < ApplicationController
  def show
    result = GetFamily.call(id: params[:id])
    return render json: result.user, include: %i[children parents] if result.success?

    render json: { errors: result.error }, status: :not_found
  end
end
