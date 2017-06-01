module V1
  class UnitResource < BaseResource
    attribute :title
    attribute :number
    
    has_one :theory
    has_one :theme
  end
end
