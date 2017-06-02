require "rspec_api_documentation_helper"

RSpec.resource "Answers" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "answer parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Always "answers".
    DESC

    let "type" do
      "answers"
    end

    parameter "text", <<~DESC, scope: :attributes, required: true
      The text of the answer.
    DESC

    parameter "sentence", <<~DESC, scope: :relationships, required: true
      The sentence of the answer.
    DESC
  end

  post "/v1/answers" do
    include_context "answer parameters"

    let "text" do
      "in Canada from 1991 to 1999"
    end

    let! :persisted_sentence do
      FactoryGirl.create(:sentence)
    end

    let "sentence" do
      {
        data: {
          type: "sentences",
          id: persisted_sentence.id.to_s
        }
      }
    end

    example_request "POST /v1/answers" do
      expect(status).to eq 201
      answer = JSON.parse(response_body)
      expect(answer["data"]["attributes"]["text"]).to eq public_send("text")
    end
  end

  shared_context "with a persisted answer" do
    let! :persisted_answer do
      FactoryGirl.create(:answer)
    end

    let "answer_id" do
      persisted_answer.id.to_s
    end
  end

  get "/v1/answers/:answer_id" do
    include_context "with a persisted answer"

    example_request "GET /v1/answers/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/answers/:answer_id" do
    include_context "answer parameters"
    include_context "with a persisted answer"

    parameter :id, <<~DESC, required: true
      The id of the answer.
    DESC

    let :id do
      persisted_answer.id.to_s
    end

    let "text" do
      "Alex lived in Canada for eight years"
    end

    example_request "PATCH /v1/answers/:id" do
      expect(status).to eq 200
      answer = JSON.parse(response_body)
      expect(answer["data"]["attributes"]["text"]).to eq public_send("text")
    end
  end

  get "/v1/answers" do
    before do
      2.times do
        FactoryGirl.create(:answer)
      end
    end

    example_request "GET /v1/answers" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  delete "/v1/answers/:answer_id" do
    include_context "with a persisted answer"

    example_request "DELETE /v1/answers/:id" do
      expect(status).to eq 204
    end
  end
end
