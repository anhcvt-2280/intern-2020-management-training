FactoryBot.define do
  factory :department do
    name {Faker::Team.unique.name}
  end
end
