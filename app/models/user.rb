# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :ancestors, foreign_key: :child_id, class_name: 'Family'
  has_many :descendants, foreign_key: :parent_id, class_name: 'Family'

  has_many :children, through: :descendants, source: :child
  has_many :parents, through: :ancestors, source: :parent

  scope :random, -> { order(Arel.sql('RANDOM()')) }
  scope :filter_by_name, ->(name) { where("data -> 'name' ->> 'first' ILIKE ?", name) }
  scope :filter_children_by_country, lambda { |country|
    where("data ->> 'nat' ILIKE ? AND data -> 'dob' ->> 'age' < '20'", "%#{country}%")
  }
  scope :filter_parents_by_country, lambda { |country|
    where("data ->> 'nat' ILIKE ? AND data -> 'dob' ->> 'age' >= '30'", "%#{country}%")
  }
  scope :without_both_parents, lambda {
    left_outer_joins(:ancestors).group(:id).having('count(*) < 2')
  }
end
