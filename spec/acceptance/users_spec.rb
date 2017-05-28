require "rspec_api_documentation_helper"

RSpec.resource "Users" do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/users" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Must be users.
    DESC

    let "type" do
      "users"
    end

    parameter "firstname", <<~DESC, scope: :attributes, required: true
      The first name of the user.
    DESC

    let "firstname" do
      "Neil"
    end

    parameter "lastname", <<~DESC, scope: :attributes, required: true
      The last name of the user.
    DESC

    let "lastname" do
      "Zag"
    end

    parameter "email-address", <<~DESC, scope: :attributes, required: true
      The email address of the user.
    DESC

    let "email-address" do
     "karimnail96@gmail.com" 
    end

    parameter "password", <<~DESC, scope: :attributes, required: true
      The password for the user.
    DESC

    let "password" do
      "12344321"
    end

    example_request "POST /v1/users" do
      expect(status).to eq 201
      
    end
  end
end
