class Shop < ApplicationRecord
    
    has_many :products
    has_many :places
end
