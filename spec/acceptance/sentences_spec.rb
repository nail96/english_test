require "rspec_api_documentation_helper"

RSpec.resource "Sentences" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "sentence parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Always "sentences".
    DESC

    let "type" do
      "sentences"
    end

    parameter "text", <<~DESC, scope: :attributes, required: true
      The text of the sentence.
    DESC

    parameter "has-specific-answer", <<~DESC, scope: :attributes
      The boolean value for specific answer.
    DESC

    parameter "exercise", <<~DESC, scope: :relationships, required: true
      The exercise of the sentence.
    DESC

    parameter "answer", <<~DESC, scope: :relationships
      The answer of the sentence.
    DESC
  end

  post "/v1/sentences" do
    include_context "sentence parameters"

    let "text" do
      "Alex lived {}"
    end

    let "has-specific-answer" do
      true
    end

    let! :persisted_exercise do
      FactoryGirl.create(:exercise)
    end

    let "exercise" do
      {
        data: {
          type: "exercises",
          id: persisted_exercise.id.to_s
        }
      }
    end

    example_request "POST /v1/sentences" do
      expect(status).to eq 201
      sentence = JSON.parse(response_body)
      expect(sentence["data"]["attributes"]["text"]).to eq public_send("text")
    end
  end

  shared_context "with a persisted sentence" do
    let! :persisted_sentence do
      FactoryGirl.create(:sentence)
    end

    let "sentence_id" do
      persisted_sentence.id.to_s
    end
  end

  get "/v1/sentences/:sentence_id" do
    include_context "with a persisted sentence"

    example_request "GET /v1/sentences/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/sentences/:sentence_id" do
    include_context "sentence parameters"
    include_context "with a persisted sentence"

    parameter :id, <<~DESC, required: true
      The id of the sentence.
    DESC

    let :id do
      persisted_sentence.id.to_s
    end

    let "text" do
      "Alex lived in Canada {} 1999."
    end

    example_request "PATCH /v1/sentences/:id" do
      expect(status).to eq 200
      sentence = JSON.parse(response_body)
      expect(sentence["data"]["attributes"]["text"]).to eq public_send("text")
    end
  end

  get "/v1/sentences" do
    before do
      2.times do
        FactoryGirl.create(:sentence)
      end
    end

    example_request "GET /v1/sentences" do
      expect(status).to eq 200
      sentence = JSON.parse(response_body)
      expect(sentence["data"].size).to eq 2
    end
  end

  delete "/v1/sentences/:sentence_id" do
    include_context "with a persisted sentence"

    example_request "DELETE /v1/sentences/:id" do
      expect(status).to eq 204
    end
  end
end
