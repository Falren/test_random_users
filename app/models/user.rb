# frozen_string_literal: true

class User < ActiveRecord::Base
  CHILD_MAX_AGE = 20
  PARENT_MIN_AGE = 30
  MAX_NUMBER_OF_CHILDREN = 5
  MAX_NUMBER_OF_PARENTS_PER_CHILD = 2

  has_many :ancestors, foreign_key: :child_id, class_name: 'Family'
  has_many :descendants, foreign_key: :parent_id, class_name: 'Family'

  has_many :children, through: :descendants, source: :child
  has_many :parents, through: :ancestors, source: :parent

  scope :random, -> { order(Arel.sql('RANDOM()')) }
  scope :filter_by_name, ->(name) { where("lower(data -> 'name' ->> 'first') LIKE ?", "%#{name.downcase}%") }
  scope :filter_children_by_country, lambda { |country|
    where(
      "lower(data ->> 'nat') LIKE ? AND data -> 'dob' ->> 'age' < ?",
      "%#{country.downcase}%",
      CHILD_MAX_AGE.to_s
    )
  }
  scope :filter_parents_by_country, lambda { |country|
    where(
      "lower(data ->> 'nat') LIKE ? AND data -> 'dob' ->> 'age' >= ?",
      "%#{country.downcase}%",
      PARENT_MIN_AGE.to_s
    )
  }
  scope :without_both_parents, lambda {
    left_outer_joins(:ancestors).group(:id).having('count(*) < ?', MAX_NUMBER_OF_PARENTS_PER_CHILD)
  }
end
