class Theme < ApplicationRecord
  has_and_belongs_to_many :books

  validates :title, presence: true
end
