class Book < ApplicationRecord
  has_and_belongs_to_many :themes

  validates :title, presence: true
end
