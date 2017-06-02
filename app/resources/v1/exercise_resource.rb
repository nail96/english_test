module V1
  class ExerciseResource < BaseResource
    attribute :title

    has_one :unit
    
    has_many :sentences

    class << self
      def creatable_fields(context)
        super - [:sentences]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
