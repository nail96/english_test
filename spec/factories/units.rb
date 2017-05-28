FactoryGirl.define do
  factory :unit do
    title "from ... to   until   since   for"
    number 104
    association :theory, strategy: :build
    association :theme, strategy: :build
  end
end
