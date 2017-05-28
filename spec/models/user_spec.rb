RSpec.describe User do
  %w(firstname lastname email_address).each do |required_attribute|
    it { is_expected.to have_attribute required_attribute }
    it { is_expected.to validate_presence_of required_attribute }
  end

  it "validates the uniqueness of email_address" do
    subject = FactoryGirl.build(:user)
    puts subject.inspect
    subject.save!
  end
end
