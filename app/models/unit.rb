class Unit < ApplicationRecord
  belongs_to :theory
  belongs_to :theme
  has_many   :exercises

  validates :title, presence: true
end
