class Order < ApplicationRecord
    belongs_to :booking

    has_many :items, dependent: :destroy
    delegate :table, to: :booking
    # validates :product, presence: true 
    # validates :quantity, presence: true, numericality: true
    # validates :price, presence:true
    
end
