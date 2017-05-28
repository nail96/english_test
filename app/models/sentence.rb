class Sentence < ApplicationRecord
  belongs_to :exercise

  validates :text, presence: true
  validates :has_specific_answer, presence: true
end
