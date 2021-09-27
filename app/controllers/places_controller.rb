class PlacesController < ApplicationController
before_action :set_shop

    def index
    end
    def show
        set_place
        @tables = @place.all
    end
    def new
        @place = @shop.places.new
    end
    def create
        @place = @shop.places.new(place_params)

        if @place.save
            redirect_back(fallback_location: root_path, notice: "El espacio fue agregado satisfactoriamente.")
          else
            render :new, status: :unprocessable_entity 
          end
    end

    private
    def set_shop
        @shop = Shop.find_by_nick(params[:shop_nick])
    end
    def set_place
        set_shop
        @place = @shop.find(params[:place_id])
    end
    def place_params
        params.require(:place).permit(:name,:description)
      end
end
