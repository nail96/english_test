RSpec.describe Book do
  it { is_expected.to have_attribute :title }

  it { is_expected.to validate_presence_of :title }
end
