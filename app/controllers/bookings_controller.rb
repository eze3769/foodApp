class BookingsController < ApplicationController
    before_action :set_shop, :set_place, :set_table, only: [:create,:close]
    def create 
        @table.bookings.create(status:'open')
        redirect_back(fallback_location: root_path , notice: "La sesión en la mesa #{@table.name} fué abierta satisfactoriamente.")
    end

    def close
        booking = @table.bookings.find_by_status('open')
        booking.status = 'closed'
        booking.save

        redirect_back(fallback_location: root_path , notice: "La mesa #{@table.name} fué cerrada satisfactoriamente.")
    end

    private
    def set_shop
        @shop = Shop.find_by_nick(params[:shop_nick])
    end
    def set_place
        @place = @shop.places.find(params[:place_id])
    end
    def set_table
        @table = @place.tables.find(params[:table_id])
    end
end
