FactoryGirl.define do
  factory :user do
    firstname "Neil"
    lastname "Zag"
    sequence (:email_address) { |n| "test-#{n}@test.com" }
    password "12344321"
  end
end
