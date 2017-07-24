FactoryGirl.define do
  factory :movie do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
    released_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    genre

    transient do
      comment_count 0
    end
    
    trait :with_comments do
      after(:create) do |movie, evaluator|
        user = create :user
        create_list :comment, evaluator.comment_count, movie_id: movie.id, user_id: user.id
      end
    end
  end
end
