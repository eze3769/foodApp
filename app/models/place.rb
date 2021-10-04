class Place < ApplicationRecord
    belongs_to :shop
    has_many :tables

    validates :name, presence: {message: 'Debe ingresar un nombre'}, uniqueness:{message:'El nombre ya existe.'}
end
