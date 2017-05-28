RSpec.describe Exercise do
  it { is_expected.to have_attribute :title }

  it { is_expected.to belong_to :unit }
  it { is_expected.to have_many :sentences }

  it { is_expected.to validate_presence_of :title }
end
