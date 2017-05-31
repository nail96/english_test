module V1
  class BookResource < BaseResource
    attribute :title
    
    has_many :themes
  end
end
