require "rspec_api_documentation_helper"

RSpec.resource "Exercises" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "exercise parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Always "exercises".
    DESC

    let "type" do
      "exercises"
    end

    parameter "title", <<~DESC, scope: :attributes, required: true
      The title of the exercise.
    DESC

    parameter "unit", <<~DESC, scope: :relationships, required: true
      The unit of the exercise.
    DESC

    parameter "sentences", <<~DESC, scope: :relationships
      The sentences of the exercise.
    DESC
  end

  post "/v1/exercises" do
    include_context "exercise parameters"

    let "title" do
      "Read the information and complete the sentences. User from ... to / until / since."
    end

    let! :persisted_unit do
      FactoryGirl.create(:unit)
    end

    let "unit" do
      {
        data: {
          type: "units",
          id: persisted_unit.id.to_s
        }
      }
    end

    example_request "POST /v1/exercises" do
      expect(status).to eq 201
      exercise = JSON.parse(response_body)
      expect(exercise["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end

  shared_context "with a persisted exercise" do
    let! :persisted_exercise do
      FactoryGirl.create(:exercise)
    end

    parameter :id, <<~DESC, required: true
      The id of the exercise.
    DESC

    let "exercise_id" do
      persisted_exercise.id.to_s
    end
  end

  get "/v1/exercises/:exercise_id" do
    include_context "with a persisted exercise"

    example_request "GET /v1/exercises/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/exercises/:exercise_id" do
    include_context "exercise parameters"
    include_context "with a persisted exercise"

    let :id do
      persisted_exercise.id.to_s
    end

    let "title" do
      "Write until/since/for."
    end

    example_request "PATCH /v1/exercises/:id" do
      expect(status).to eq 200
      exercise = JSON.parse(response_body)
      expect(exercise["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end

  get "/v1/exercises" do
    before do
      2.times do
        FactoryGirl.create(:exercise)
      end
    end

    example_request "GET /v1/exercises" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  delete "/v1/exercises/:exercise_id" do
    include_context "with a persisted exercise"

    example_request "DELETE /v1/exercises/:id" do
      expect(status).to eq 204
    end
  end
end
