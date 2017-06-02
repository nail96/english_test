require "rspec_api_documentation_helper"

RSpec.resource "Books" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "book parameters" do
    parameter "type", <<~DESC, required: true
      The type of the resource. Always 'books'.
    DESC

    let "type" do
      "books"
    end

    parameter "title", <<~DESC, scope: :attributes, required: true
      The title of the book.
    DESC

    parameter "themes", <<~DESC, scope: :relationships
      The themes of the book.
    DESC
  end

  post "/v1/books" do
    include_context "book parameters"

    let "title" do
      "Essentail Grammar in Use"
    end

    let! :persisted_theme do
      FactoryGirl.create(:theme)
    end

    let "themes" do
      {
        data: [
          {
            type: "themes",
            id: persisted_theme.id.to_s
          }
        ]
      }
    end

    example_request "POST /v1/books" do
      expect(status).to eq 201
    end
  end

  shared_context "with a persisted book" do
    let! :persisted_book do
      FactoryGirl.create(:book)
    end

    let "book_id" do
      persisted_book.id.to_s
    end
  end

  get "/v1/books/:book_id" do
    include_context "book parameters"
    include_context "with a persisted book"

    example_request "GET /v1/books/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/books/:book_id" do
    include_context "book parameters"
    include_context "with a persisted book"

    parameter :id, <<~DESC, required: true
      The id of the book.
    DESC

    let :id do
      persisted_book.id.to_s
    end

    let "title" do
      "English Grammar in Use"
    end

    example_request "PATCH /v1/books/:id" do
      expect(status).to eq 200
      book = JSON.parse(response_body)
      expect(book["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end

  get "/v1/books" do
    before do
      2.times do
        FactoryGirl.create(:book)
      end
    end

    example_request "GET /v1/books" do
      expect(status).to eq 200
    end
  end

  delete "/v1/books/:book_id" do
    include_context "with a persisted book"

    example_request "DELETE /v1/books/:id" do
      expect(status).to eq 204
    end
  end
end
