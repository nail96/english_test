RSpec.describe Sentence do
  it { is_expected.to have_attribute :text }
  it { is_expected.to have_attribute :has_specific_answer }

  it { is_expected.to belong_to :exercise }

  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :has_specific_answer }
end
