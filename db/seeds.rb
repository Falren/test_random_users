# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

RANDOM_USER_URL = 'https://randomuser.me/api/'.freeze

params = { need_parents_only: false, url: "#{RANDOM_USER_URL}?results=200" }

loop do
  interaction = PopulateDb.call(params)
  break puts(interaction.message) if interaction.failure?

  puts("Children without both parents: #{interaction.children_without_both_parents.values.size}")
  country_list = interaction.children_without_both_parents.pluck(Arel.sql("data->'nat'")).join(',')
  params = {
    need_parents_only: true,
    url: "#{RANDOM_USER_URL}?results=50&nat=#{country_list}",
    children_without_both_parents: interaction.children_without_both_parents
  }
end
