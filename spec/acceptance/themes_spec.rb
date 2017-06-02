require "rspec_api_documentation_helper"

RSpec.resource "Themes" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "theme parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Always "themes".
    DESC

    let "type" do
      "themes"
    end

    parameter "title", <<~DESC, scope: :attributes, required: true
      The title of the theme.
    DESC

    parameter "books", <<~DESC, scope: :relationships
      The book of the theme.
    DESC

    parameter "units", <<~DESC, scope: :relationships
      The units of the theme.
    DESC
  end

  post "/v1/themes" do
    include_context "theme parameters"

    let "title" do
      "Present Simple"
    end

    let! :persisted_book do
      FactoryGirl.create(:book)
    end

    let "books" do
      {
        data: [
          {
            type: "books",
            id: persisted_book.id.to_s
          }
        ]
      }
    end

    example_request "POST /v1/themes" do
      expect(status).to eq 201
    end
  end

  shared_context "with a persisted theme" do
    let! :persisted_theme do
      FactoryGirl.create(:theme)
    end

    let "theme_id" do
      persisted_theme.id.to_s
    end
  end

  get "/v1/themes/:theme_id" do
    include_context "with a persisted theme"

    example_request "GET /v1/themes/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/themes/:theme_id" do
    include_context "theme parameters"
    include_context "with a persisted theme"

    parameter :id, <<~DESC, required: true
      The id of the theme.
    DESC

    let :id do
      persisted_theme.id.to_s
    end

    let "title" do
      "Present Continuous"
    end

    example_request "PATCH /v1/themes/:id" do
      expect(status).to eq 200
      theme = JSON.parse(response_body)
      expect(theme["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end

  get "/v1/themes" do
    before do
      2.times do
        FactoryGirl.create(:theme)
      end
    end

    example_request "GET /v1/themes" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  delete "/v1/themes/:theme_id" do
    include_context "with a persisted theme"

    example_request "DELETE /v1/theme/:id" do
      expect(status).to eq 204
    end
  end
end
