class OrdersController < ApplicationController

    def index
        set_shop
        if params[:place_id]
            @place = @shop.places.find(params[:place_id])
        else
            @place = @shop.places.first
        end
        
        @products= @shop.products.all
        @tables = @place.tables.all
       
    end
    def show
        set_shop
        place = @shop.places.find(params[:place_id])
        @table = place.tables.find(params[:table_id])
        booking = @table.bookings.where(status:'open').first
        @orders = booking.orders

        @subtotal = 0
        if @orders then
            @orders.each do |order|
                @subtotal += order.price
            end
        end
        respond_to do |format|
            format.js
        end
    end
    def create
        set_shop
        set_table
        booking = @table.bookings.last
        product_data = @shop.products.find(params[:product_data])

        if booking.orders.exists?(:id => product_data) then
            order = booking.orders.find(product_data.id)
            order.quantity += 1
            order.save

        else
        new_product = {product:product_data.name,quantity:1,price:product_data.price}
        booking.orders.create(new_product)
        end
      
    end

    private
    def set_shop
        @shop = Shop.find_by_nick(params[:shop_nick])
    end
    def set_table
        place = @shop.places.find(params[:place_id])
        @table = place.tables.find(params[:table_id])
    end
end
