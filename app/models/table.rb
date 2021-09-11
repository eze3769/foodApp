class Table < ApplicationRecord
    has_many :bookings
    belongs_to :place
end
