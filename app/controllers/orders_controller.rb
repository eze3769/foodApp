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
        @booking = @table.bookings.last
        
      
        respond_to do |format|
            format.js
        end
    end

    private
    def set_shop
        @shop = Shop.find_by_nick(params[:shop_nick])
    end
end
