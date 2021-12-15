class Shop < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :products
    has_many :places
    has_many :categories
    has_many :employeers
    has_many :tables, through: :places
    has_many :bookings, through: :tables
    has_many :orders, through: :bookings

    has_one_attached :background
    has_one_attached :logo

    validates :email, presence: {message: 'Ingrese un email válido'},uniqueness:{message:'email en uso'}, length: { maximum: 50, message:'Email demasiado largo' }
    validates :name, presence: {message: 'Ingrese un nombre válido'},uniqueness:{message:'Nombre de comercio en uso'}, length: { maximum: 50, message:'Nombre demasiado largo' }
    validates :nick, presence: {message: 'Ingrese un nick válido'},uniqueness:{message:'Nick en uso'}, format: { with: /\A[a-zA-Z]+\z/,
        message: "No incluir espacios ni caractéres especiales" }, length: { maximum: 80, message:'Nick demasiado largo' }
    validates :country, :state, :city, presence: {message: "Ingrese un %{attribute} válido"}, length: { maximum: 50, message:'Nombre demasiado largo' }
    validates :address, presence: {message: 'Ingrese un domicilio válido'}, length: { maximum: 50, message:'Email demasiado largo' }
    
    validates :logo, file_size: { less_than_or_equal_to: 100.kilobytes, message:'La imágen tiene que pesar menos de 100 kb' },
    file_content_type: { allow: ['image/jpeg','image/jpg', 'image/png'], message:'Los formatos aceptados son .jpg, .jpeg, .png.' }
end
