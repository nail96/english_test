RSpec.describe Unit do
  it { is_expected.to have_attribute :title }
  it { is_expected.to have_attribute :number }

  it { is_expected.to belong_to :theme }
  it { is_expected.to belong_to :theory }
  it { is_expected.to have_many :exercises }

  it { is_expected.to validate_presence_of :title }
end
