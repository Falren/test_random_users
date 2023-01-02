# frozen_string_literal: true

class Api::V1::ParentsController < ApplicationController
  def index
    render json: User.filter_parents_by_country(params[:country])
  end
end
