class Pen < ApplicationRecord
  belongs_to :post
  # validates :use_pen, presence: true
end
