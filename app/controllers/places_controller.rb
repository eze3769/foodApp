class PlacesController < ApplicationController
    def index
    end
    def show

        @place = Shop.first.Place.first
        @tables = @place.all
    end

    private
    def set_shop
        @shop = Shop.find_by_nick(params[:shop_nick])
    end
    def set_place
        set_shop
        @place = @shop.find(params[:place_id])
    end
end
