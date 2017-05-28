FactoryGirl.define do
  factory :exercise do
    title "Read the information and complete the sentences. Use from ... to / until / since."
    association :unit, strategy: :build
  end
end
