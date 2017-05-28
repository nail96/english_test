class User < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email_address, presence: true, uniqueness: true
end
