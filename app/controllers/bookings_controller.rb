class BookingsController < ApplicationController
    before_action :set_booking, only: [:close, :update, :edit, :create]
    def create 
        @booking = @table.bookings.new 
        @booking.status = 'open'


        if @booking.save
            redirect_back(fallback_location: root_path , notice: "La sesión en la mesa #{@table.name} fué abierta satisfactoriamente.")
        else
            redirect_back(fallback_location: root_path , alert:"No se pudo modificar el producto, intente más tarde.")
        end
    end

    def index
        @shop = Shop.find_by_nick(params[:shop_nick])
        @places = @shop.places
        
        if @places then
            @bookings = []
            @places.each do |place|
                place.tables.each do |table|
                    @bookings += table.bookings
                end
            end
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
        @subtotal = 0
        @booking.orders.each do |order|
            @subtotal += order.price * order.quantity
        end
        
        @booking.status = 'closed'
        @booking.total = @subtotal
        @booking.save

        redirect_back(fallback_location: root_path , notice: "La mesa #{@table.name} fué cerrada satisfactoriamente.")
    end

    private
   
    def set_booking
        @shop = Shop.find_by_nick(params[:shop_nick])
        @place = @shop.places.find(params[:place_id])
        @table = @place.tables.find(params[:table_id])
        @booking = @table.bookings.find_by_status('open')
    end
    def booking_params
        params.require(:booking).permit(:user,:phone,:address,:email)
    end
end
