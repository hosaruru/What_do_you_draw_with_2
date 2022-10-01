class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :posts, through: :tagmaps
end
