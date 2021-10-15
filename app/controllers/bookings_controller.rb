class BookingsController < ApplicationController
    before_action :set_shop, :set_place, :set_table, only: [:create,:close, :update, :edit]
    before_action :set_booking, only: [:close, :update, :edit]
    def create 
        @booking = @table.bookings.new 
        @booking.status = 'open'


        if @booking.save
            redirect_back(fallback_location: root_path , notice: "La sesión en la mesa #{@table.name} fué abierta satisfactoriamente.")
        else
            redirect_back(fallback_location: root_path , alert:"No se pudo modificar el producto, intente más tarde.")
        end
    end
    def edit

    end
    def update
        set_booking
        @booking.update(booking_params)
      if @booking.save
         redirect_back(fallback_location: root_path, notice: "El producto fue actualizado correctamente" )
      else
        render :new, status: :unprocessable_entity, alert:"No se pudo modificar el producto, intente más tarde."
      end
    end

    def close
        set_booking
        @booking.status = 'closed'
        @booking.total = @subtotal
        @booking.save

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
    def set_booking
        @booking = @table.bookings.find_by_status('open')
    end
    def booking_params
        params.require(:booking).permit(:user,:phone,:address,:email)
    end
end
