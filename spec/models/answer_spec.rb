RSpec.describe Answer do
  it { is_expected.to have_attribute :text }
  
  it { is_expected.to belong_to :sentence }
end
