module V1
  class SentenceResource < BaseResource
    attribute :text
    attribute :has_specific_answer

    has_one :exercise

    has_one :answer

    class << self
      def creatable_fields(context)
        super - [:answer]
      end

      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:answer]
    end
  end
end
