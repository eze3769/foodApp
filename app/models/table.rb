class Table < ApplicationRecord
    has_many :bookings
    belongs_to :place

    validates :name, numericality:{ message: "El nombre de la mesa debe ser numérico"}, uniqueness:{message:'Nombre en uso'}

end
