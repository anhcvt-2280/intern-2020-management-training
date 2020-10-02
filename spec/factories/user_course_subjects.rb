FactoryBot.define do
  factory :user_course_subject do
    user_course {FactoryBot.create :user_course}
    course_subject
    user
    progress {Faker::Number.decimal l_digits: 2}
    deadline {Faker::Date.between(from: "2019-11-23", to: "2020-10-25")}
  end
end
