module V1
  class ThemeResource < BaseResource
    attribute :title

    has_many :books
  end
end
