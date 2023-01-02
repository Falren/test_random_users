# frozen_string_literal: true

class CreateFamilyService
  def initialize(params)
    @params = params
  end

  def call
    params[:children].each do |child|
      next if params[:adults][child.data['nat']].blank?

      create_family(child)
    end
  end

  private

  attr_reader :params

  def create_family(child)
    parent_ids = params[:adults][child.data['nat']].slice!(0..1).pluck(:id)
    child.parent_ids = parent_ids
  end
end
