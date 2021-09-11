class ProductsController < ApplicationController

    def product_modal
        shop = Shop.find_by_nick(params[:shop_nick])

        @product_data = shop.products.find(params[:product_data])
        
        respond_to do |format|
          format.js
        end
      end
      def products_list_modal
        
        shop = Shop.find_by_nick(params[:shop_nick])
        @place = shop.places.find(params[:place_id])
        @table = @place.tables.find(params[:table_id])
        @product_list = shop.products.all
        @booking = @table.bookings.last
        @state = true
        if @booking == nil then
            @state = false
        elsif @booking.status == "closed" then
            @state = false
        end
      
        respond_to do |format|
          format.js
        end
      end
end
