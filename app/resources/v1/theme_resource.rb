module V1
  class ThemeResource < BaseResource
    attribute :title

    has_many :books
    has_many :units

    class << self
      def creatable_fields(context)
        super - [:units]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
