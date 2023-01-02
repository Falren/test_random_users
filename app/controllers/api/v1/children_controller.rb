# frozen_string_literal: true

class Api::V1::ChildrenController < ApplicationController
  def index
    return render json: { error: 'This country is not available' }, status: :not_found unless country_available

    return render json: { error: 'No children in this country' }, status: :not_found unless available_children.present?

    render json: available_children
  end

  private

  def country_available
    @country_available ||= User.available_countries.include?(params[:country])
  end

  def available_children
    @available_children ||= User.filter_children_by_country(params[:country])
  end
end
