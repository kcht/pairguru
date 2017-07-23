FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n.to_s}
    email { "fake#{id}@fake.com" }
    name { 'Faker' }
    password { 'testtesttest'}
    password_confirmation { 'testtesttest'}
  end
end