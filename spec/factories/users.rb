FactoryGirl.define do
  factory :user do
    firstname "Neil"
    lastname "Zag"
    sequence (:email_address) { |n| "test-#{n}@test.com" }
  end
end
