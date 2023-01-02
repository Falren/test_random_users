# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

params = { parents_only: false, url: 'https://randomuser.me/api/?results=200' }

loop do
  families = PopulateDb.call(params)
  break if families.failure?

  country_list = families.children_without_both_parents.pluck(Arel.sql("data->'nat'")).join(',')
  params = {
    parents_only: true,
    url: "https://randomuser.me/api/?results=50&nat=#{country_list}",
    children_without_both_parents: families.children_without_both_parents
  }
end
