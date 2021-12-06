class BookingsController < ApplicationController
    before_action :set_table, only: [:show]
    before_action :set_booking, only: [:close, :update, :edit, :create]
    
    def show
        @booking = Booking.find(params[:booking_id])
        @orders = @booking.orders
        @subtotal = 0
        if @orders then
            @orders.each do |order|
                order.items.each do |item|
                    @subtotal += item.product.price * item.quantity
                end
            end
        end
    end
    
    def create 

        set_employeer = @shop.employeers.find(params[:booking][:employeer])
        @booking = @table.bookings.new 
        @booking.status = 'open'
        @booking.employeer = set_employeer
        
        @product_list = @shop.products

        if @booking.save
            redirect_back(fallback_location: root_path , notice: "La sesión en la mesa #{@table.name} fué abierta satisfactoriamente.")
            
        else
            redirect_back(fallback_location: root_path , status: :unprocessable_entity, alert:"No se pudo guardar la reserva, intente más tarde.")
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
        employeer = @shop.employeers.find(params[:booking][:employeer])
        if @booking.update(employeer:employeer) then

            redirect_back(fallback_location: root_path, notice: "La reserva fue actualizada correctamente" )
        else
            render :new, status: :unprocessable_entity, alert:"No se pudo modificar la reserva, intente más tarde."
        end
    end

    def close
        set_booking
        @subtotal = 0

        
        
        @booking.status = 'closed'
        @booking.total = @subtotal
        
        if @booking.save
            redirect_back(fallback_location: root_path, notice: "La reserva de la mesa #{@table.name} fue cerrada satisfactoriamente" )
        else
            redirect_back(fallback_location: root_path, alert:"No se pudo modificar la reserva de la mesa #{@table.name}, intente más tarde.")
        end

       
    end

    private
   
    def set_table
        @shop = Shop.find_by_nick(params[:shop_nick])
        @place = @shop.places.find(params[:place_id])
        @table = @place.tables.find(params[:table_id])
    end
    def set_booking
        set_table
        @booking = @table.bookings.find_by_status('open')
    end
    def booking_params
        params.require(:booking).permit(:user,:phone,:address,:email, :employeer)
    end
end
