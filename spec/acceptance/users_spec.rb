require "rspec_api_documentation_helper"

RSpec.resource "Users" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "user parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Must be users.
    DESC

    let "type" do
      "users"
    end
 
    parameter "firstname", <<~DESC, scope: :attributes, required: true
      The first name of the user.
    DESC

    parameter "lastname", <<~DESC, scope: :attributes, required: true
      The last name of the user.
    DESC

    parameter "email-address", <<~DESC, scope: :attributes, required: true
      The email address of the user.
    DESC

    parameter "password", <<~DESC, scope: :attributes, required: true
      The password for the user.
    DESC
  end

  post "/v1/users" do
    include_context "user parameters"

    let "firstname" do
      "Neil"
    end

    let "lastname" do
      "Zag"
    end

    let "email-address" do
     "karimnail96@gmail.com" 
    end
   
    let "password" do
      "12344321"
    end

    example_request "POST /v1/users" do
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["email-address"]).to eq public_send("email-address")
    end
  end

  shared_context "with a persisted user" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let "user_id" do
      persisted_user.id.to_s
    end
  end

  get "/v1/users/:user_id" do
    include_context "with a persisted user"

    example_request "GET /v1/users/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/users/:user_id" do
    include_context "user parameters"
    include_context "with a persisted user"

    parameter :id, <<~DESC, required: true
      The id of the user.
    DESC

    let :id do
      persisted_user.id.to_s
    end

    let "firstname" do
      "Nail"
    end

    example_request "PATCH /v1/users/:id" do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["firstname"]).to eq public_send("firstname")
    end
  end

  get "/v1/users" do
    before do
      2.times do
        FactoryGirl.create(:user)
      end
    end

    example_request "GET /v1/users" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end
end
