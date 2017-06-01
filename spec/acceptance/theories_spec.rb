require "rspec_api_documentation_helper"

RSpec.resource "Theories" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "theory parameters" do
    parameter "type", <<~DESC, required: true
      Teh type of the resource. Always "theories".
    DESC

    let "type" do
      "theories"
    end

    parameter "image", <<~DESC, scope: :attributes, required: true
      The image of the theories.
    DESC

    parameter "links", <<~DESC, scope: :attributes
      The links of the theories.
    DESC
  end

  post "/v1/theories" do
    include_context "theory parameters"

    let! :valid_base64_image do
      Base64.encode64(File.read(Rails.root.join("public", "images", "104.png")))
    end

    let "image" do
      "data:image/png;base64,#{valid_base64_image}"
    end

    let "links" do
      "https://www.youtube.com/watch?v=_c17mWStGEE&index=1&list=PLYB0SmefqEsniU1UbGzrfhNCV3noALHj7;https://www.youtube.com/watch?v=AwXgE1kVEiQ&index=2&list=PLYB0SmefqEsniU1UbGzrfhNCV3noALHj7"
    end

    example_request "POST /v1/theories" do
      expect(status).to eq 201
      images = JSON.parse(response_body)
                   .fetch("data")
                   .fetch("attributes")
                   .fetch("image")
      expect(images["url"]).to be_present
      links = JSON.parse(response_body)
                  .fetch("data")
                  .fetch("attributes")
                  .fetch("links")
      expect(links.split(%r{;\s*}).size).to eq 2
    end
  end

  shared_context "with a persisted theory" do
    let! :persisted_theory do
      FactoryGirl.create(:theory)
    end

    let "theory_id" do
      persisted_theory.id.to_s
    end
  end

  get "/v1/theories/:theory_id" do
    include_context "with a persisted theory"

    example_request "GET /v1/theories/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/theories/:theory_id" do
    include_context "theory parameters"
    include_context "with a persisted theory"

    parameter :id, <<~DESC, required: true
      The id of the theme.
    DESC

    let :id do
      persisted_theory.id.to_s
    end

    let! :valid_base64_image do
      Base64.encode64(File.read(Rails.root.join("public", "images", "1.jpg")))
    end

    let "image" do
      "data:image/jpeg;base64,#{valid_base64_image}"
    end

    example_request "PATCH /v1/theories/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/theories" do
    before do
      2.times do
        FactoryGirl.create(:theory)
      end
    end

    example_request "GET /v1/theories" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  delete "/v1/theories/:theory_id" do
    include_context "with a persisted theory"

    example_request "DELETE /v1/theories/:id" do
      expect(status).to eq 204
    end
  end
end
