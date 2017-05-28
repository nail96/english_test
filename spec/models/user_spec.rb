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

  it "persists a password digest based on the password that can be used for authentication" do
    password = "password"
    subject = FactoryGirl.create(:user, password: password)
    expect(subject.authenticate(password)).to eq subject
  end
end
