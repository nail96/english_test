FactoryGirl.define do
  factory :answer do
    text "{in Canada from 1991 to 1999}"
    association :sentence, strategy: :build
  end
end
