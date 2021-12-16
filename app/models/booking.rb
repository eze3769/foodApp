class Booking < ApplicationRecord
  belongs_to :table
  has_many :orders, dependent: :destroy
  belongs_to :employeer
  
end
