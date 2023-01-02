FactoryBot.define do
  factory :user do
    trait :child do
      data do
        {
          "name": {
            "first": Faker::Name.first_name,
            "last": Faker::Name.last_name
          },
          "dob": { "age": rand(1...20) },
          "nat": 'US'
        }.as_json
      end
    end
    trait :parent do
      data do
        {
          "name": {
            "first": Faker::Name.first_name,
            "last": Faker::Name.last_name
          },
          "dob": { "age": 30 },
          "nat": 'US'
        }.as_json
      end
    end
  end
end
