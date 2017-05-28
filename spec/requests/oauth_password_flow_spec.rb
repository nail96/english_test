RSpec.describe "OAuth password flow" do
  
  let :email_address do
    "test@test.com"
  end

  let :password do
    "12344321"
  end

  let! :user do
    FactoryGirl.create(:user, email_address: email_address, password: password)
  end

  it "creates a token and returns it when the credentials are valid" do
    params = { grant_type: "password", username: email_address, password: password }
    post "/oauth/token", params: params
    expect(response.status).to eq 200
    expect(JSON.parse(response.body)["access_token"]).not_to be_nil
  end

  it "does not issue a token if the credentials are invalid" do
    params = { grant_type: "password", username: email_address, password: "bologna" }
    post "/oauth/token", params: params
    expect(response.status).to eq 401
  end

end
