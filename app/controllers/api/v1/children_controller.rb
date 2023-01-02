# frozen_string_literal: true

class Api::V1::ChildrenController < ApplicationController
  def index
    render json: User.filter_children_by_country(params[:country])
  end
end
