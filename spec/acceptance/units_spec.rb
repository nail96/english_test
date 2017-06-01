require "rspec_api_documentation_helper"

RSpec.resource "Units" do
  header "Content-Type", "application/vnd.api+json"
  
  shared_context "unit parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Always "units".
    DESC

    let "type" do
      "units"
    end

    parameter "title", <<~DESC, scope: :attributes, required: true
      The title of the unit.
    DESC

    parameter "number", <<~DESC, scope: :attributes, required: true
      The number of the unit.
    DESC

    parameter "theory", <<~DESC, scope: :relationships, required: true
      The theory of the unit.
    DESC

    parameter "theme", <<~DESC, scope: :relationships, required: true
      The theme of the unit.
    DESC
  end

  post "/v1/units" do
    include_context "unit parameters"

    let "title" do
      "from ... to   until   since   for"
    end

    let "number" do
      104
    end

    let! :persisted_theory do
      FactoryGirl.create(:theory)
    end

    let "theory" do
      {
        data: {
          type: "theories",
          id: persisted_theory.id.to_s
        }
      }
    end

    let! :persisted_theme do
      FactoryGirl.create(:theme)
    end

    let "theme" do
      {
        data: {
          type: "themes",
          id: persisted_theme.id.to_s
        }
      }
    end

    example_request "POST /v1/units" do
      expect(status).to eq 201
      unit = JSON.parse(response_body)
      expect(unit["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end

  shared_context "with a persisted unit" do
    let! :persisted_unit do
      FactoryGirl.create(:unit)
    end

    let "unit_id" do
      persisted_unit.id.to_s
    end
  end

  get "/v1/units/:unit_id" do
    include_context "with a persisted unit"

    example_request "GET /v1/units/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/units/:unit_id" do
    include_context "unit parameters"
    include_context "with a persisted unit"

    parameter :id, <<~DESC, required: true
      The id of the unit.
    DESC

    let :id do
      persisted_unit.id.to_s
    end

    let "title" do
      "from ... to    until     since     for"
    end

    example_request "PATCH /v1/themes/:id" do
      expect(status).to eq 200
      unit = JSON.parse(response_body)
      expect(unit["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end

  get "/v1/units" do
    before do
      2.times do
        FactoryGirl.create(:unit)
      end
    end

    example_request "GET /v1/units" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  delete "/v1/units/:unit_id" do
    include_context "with a persisted unit"

    example_request "DELETE /v1/units/:id" do
      expect(status).to eq 204
    end
  end
end
