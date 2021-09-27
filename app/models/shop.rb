class Shop < ApplicationRecord
    has_many :products
    has_many :places
    has_one_attached :background


    validates :email, presence: {message: 'Ingrese un email válido'},uniqueness:{message:'email en uso'}
    validates :name, presence: {message: 'Ingrese un nombre válido'},uniqueness:{message:'Nombre de comercio en uso'}
    validates :nick, presence: {message: 'Ingrese un nick válido'},uniqueness:{message:'Nick en uso'}, format: { with: /\A[a-zA-Z]+\z/,
        message: "No incluir espacios ni caractéres especiales" }
    validates :country, :state, :city, presence: {message: "Ingrese un %{attribute} válido"}
    validates :address, presence: {message: 'Ingrese un domicilio válido'}

   
end
