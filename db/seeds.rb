# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

children_without_both_parents = { family: [''] }
params = { parents_only: false, url: 'https://randomuser.me/api/?results=500' }

while children_without_both_parents[:family].any?
  children_without_both_parents = PopulateDb.call(params)
  parent_country_list = children_without_both_parents[:family].pluck(Arel.sql("data->'nat'")).join(',')
  params = {
    parents_only: true,
    url: "https://randomuser.me/api/?results=100&nat=#{parent_country_list}",
    children_without_both_parents: children_without_both_parents[:family]
  }
end
