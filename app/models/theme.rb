class Theme < ApplicationRecord
  has_and_belongs_to_many :books
  has_many :units

  validates :title, presence: true
end
