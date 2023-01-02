# frozen_string_literal: true

class Api::V1::PeopleController < ApplicationController
  def index
    render json: User.filter_by_name(params[:name])
  end
end
