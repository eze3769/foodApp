class PlacesController < ApplicationController
before_action :set_shop, only:[:new]
before_action :set_place, only:[:show,:edit,:update,:destroy]
    def index
    end
    def show
        @tables = @place.all
    end
    def new
        @place = @shop.places.new
    end
    def create
        @place = @shop.places.new(shop_params)

        if @place.save
            redirect_back(fallback_location: root_path, notice: "El espacio fué creado satisfactoriamente.")
        else
          render :new, status: :unprocessable_entity 
        end
    end
    def edit

    end
    def destroy
        @place.destroy
        redirect_back(fallback_location: root_path, notice: "El producto fué borrado satisfactoriamente.")
    end

    def update
        @place.update(place_params)
        if @place.save
          redirect_back(fallback_location: root_path, notice: "El espacio fue actualizado correctamente" )
        else
          render :new, status: :unprocessable_entity, notice:"No se pudo modificar el espacio, intente más tarde."
        end
      end
  
      def destroy
        @place.destroy
  
        redirect_back(fallback_location: root_path, notice: "El producto fué borrado satisfactoriamente.")
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
        @place = @shop.places.find(params[:place_id])
    end
    def place_params
        params.require(:place).permit(:name,:description)
      end
end
