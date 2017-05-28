class Exercise < ApplicationRecord
  belongs_to :unit
  has_many   :sentences

  validates :title, presence: true
end
