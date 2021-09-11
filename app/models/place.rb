class Place < ApplicationRecord
    belongs_to :shop
    has_many :tables
end
