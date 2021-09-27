class Product < ApplicationRecord


  belongs_to :shop

  has_one_attached :image

  validates :image, file_size: { less_than_or_equal_to: 800.kilobytes, message:'La imágen tiene que pesar menos de 800 kb' },
  file_content_type: { allow: ['image/jpeg','image/jpg', 'image/png'], message:'Los formatos aceptados son .jpg, .jpeg, .png.' }
 
end
