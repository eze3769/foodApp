class Table < ApplicationRecord
    has_many :bookings, dependent: :destroy
    belongs_to :place

    validates :name, numericality:{ message: "El nombre de la mesa debe ser numérico"}

end
