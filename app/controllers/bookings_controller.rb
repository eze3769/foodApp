class BookingsController < ApplicationController
    def create 
        shop = Shop.find_by_nick(params[:shop_nick])
        place = shop.places.find(params[:place_id])
        table = place.tables.find(params[:table_id])

        table.bookings.create(status:'open')

        redirect_back(fallback_location: root_path) 
    end
end
