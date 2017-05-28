class Exercise < ApplicationRecord
  belongs_to :unit

  validates :title, presence: true
end
