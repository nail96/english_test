module V1
  class UserResource < BaseResource
    attribute :firstname
    attribute :lastname
    attribute :email_address
    attribute :password

    def fetchable_fields
      super - [:password]
    end
  end
end
