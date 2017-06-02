module V1
  class AnswerResource < BaseResource
    attribute :text

    has_one :sentence
  end
end
