RSpec.describe Theme, type: :model do
  it { is_expected.to have_attribute :title }
  
  it { is_expected.to have_and_belong_to_many :books }
  it { is_expected.to have_many :units }

  it { is_expected.to validate_presence_of :title }
end
