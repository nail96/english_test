module V1
  class UnitResource < BaseResource
    attribute :title
    attribute :number
    
    has_one :theory
    has_one :theme
    
    has_many :exercises

    class << self
      def creatable_fields(context)
        super - [:exercises]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
