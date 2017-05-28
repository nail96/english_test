class Sentence < ApplicationRecord
  belongs_to :exercise
  has_many   :answers

  validates :text, presence: true
  validates :has_specific_answer, presence: true
end
