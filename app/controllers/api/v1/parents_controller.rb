# frozen_string_literal: true

class Api::V1::ParentsController < ApplicationController
  def index
    return render json: { error: 'This country is not available' }, status: :not_found unless country_available

    return render json: { error: 'No parents in this country' }, status: :not_found unless parents_available.present?

    render json: available_parents
  end

  private

  def country_available
    @country_available ||= User.available_countries.include?(params[:country])
  end

  def available_parents
    @available_parents ||= User.filter_parents_by_country(params[:country])
  end
end
