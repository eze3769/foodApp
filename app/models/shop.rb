class Shop < ApplicationRecord
    has_many :products
    has_many :places
    has_many :categories
    has_one_attached :background


    validates :email, presence: {message: 'Ingrese un email válido'},uniqueness:{message:'email en uso'}, length: { maximum: 50, message:'Email demasiado largo' }
    validates :name, presence: {message: 'Ingrese un nombre válido'},uniqueness:{message:'Nombre de comercio en uso'}, length: { maximum: 50, message:'Nombre demasiado largo' }
    validates :nick, presence: {message: 'Ingrese un nick válido'},uniqueness:{message:'Nick en uso'}, format: { with: /\A[a-zA-Z]+\z/,
        message: "No incluir espacios ni caractéres especiales" }, length: { maximum: 80, message:'Nick demasiado largo' }
    validates :country, :state, :city, presence: {message: "Ingrese un %{attribute} válido"}, length: { maximum: 50, message:'Nombre demasiado largo' }
    validates :address, presence: {message: 'Ingrese un domicilio válido'}, length: { maximum: 50, message:'Email demasiado largo' }

   
end
