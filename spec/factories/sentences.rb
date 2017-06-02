FactoryGirl.define do
  factory :sentence do
    text "Alex lived {}"
    has_specific_answer true
    association :exercise, strategy: :build
  end
end
