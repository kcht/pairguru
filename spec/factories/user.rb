FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n.to_s}
    email { "fake#{id}@fake.com" }
    name { 'Faker' }
    password { 'testtesttest'}
    password_confirmation { 'testtesttest'}

    transient do
      comment_count 0
    end

    trait :with_comments do
      after(:create) do |user, evaluator|
        movie = create :movie
        create_list :comment, evaluator.comment_count, movie_id: movie.id, user_id: user.id
      end
    end
  end
end