FactoryGirl.define do
  factory :sentence do
    text "Alex lived {}"
    has_specific_answer false
    association :exercise, strategy: :build
  end
end
