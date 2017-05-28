require "rspec_api_documentation"
require "rspec_api_documentation/dsl"

# Values listed are the default values
RspecApiDocumentation.configure do |config|
  # Set the application that Rack::Test uses
  config.app = Rails.application

  # Output folder
  config.docs_dir = Rails.root.join("doc", "v1", "api")

  # An array of output format(s).
  # Possible values are :json, :html, :combined_text, :combined_json,
  #   :json_iodocs, :textile, :markdown, :append_json, :slate
  config.format = [:json]

  # Filter by example document type
  config.filter = :all

  # Filter by example document type
  config.exclusion_filter = nil

  config.request_headers_to_include = ["Content-Type"]
  config.response_headers_to_include = ["Content-Type"]

  # By default examples and resources are ordered by description. Set to true keep
  # the source order.
  config.keep_source_order = true

  # Change the name of the API on index pages
  config.api_name = "English Test API Documentation"

  config.post_body_formatter = proc do |params|
    { data: params }.to_json if params.present?
  end
end
