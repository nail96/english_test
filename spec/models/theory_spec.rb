RSpec.describe Theory do
  it { is_expected.to have_attribute :image }
  it { is_expected.to have_attribute :links }

  it { is_expected.to have_one :unit }
end
