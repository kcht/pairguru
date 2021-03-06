FactoryGirl.define do
  factory :comment do
    movie
    user

    sequence(:id) {|n| n.to_s}
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence(5, true) }
  end
end
