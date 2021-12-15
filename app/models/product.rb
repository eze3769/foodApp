class Product < ApplicationRecord

  has_many :items
  belongs_to :shop

  has_one_attached :image

  validates :name, :category, presence:{message:'Tiene que llenar todos los espacios'},length: { maximum: 50, message:'Máximo 50 caractéres' }
  validates :price, numericality:{message:'Debe ingresar un número'}
  validates :description, presence:{message:'Tiene que llenar todos los espacios'},length: { maximum: 120, message:'Longitud máxima de 120 caractéres' }
  validates :image, file_size: { less_than_or_equal_to: 800.kilobytes, message:'La imágen tiene que pesar menos de 800 kb' },
  file_content_type: { allow: ['image/jpeg','image/jpg', 'image/png'], message:'Los formatos aceptados son .jpg, .jpeg, .png.' }
  
end
