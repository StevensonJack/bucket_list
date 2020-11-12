class Bucket < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  validates :title, presence: true
end
