class Activity < ApplicationRecord
  belongs_to :bucked
  has_many :offers, dependent: :destroy
  validates :title, :budget, :location, :time_frame, :people_number, :category, presence: true
end
