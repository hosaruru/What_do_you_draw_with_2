class Software < ApplicationRecord
    has_many :posts, dependent: :destroy

end
