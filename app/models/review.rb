class Review < ApplicationRecord
  belongs_to :movie
  has_many :movies, dependent: :destroy
end
