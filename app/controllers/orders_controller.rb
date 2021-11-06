class OrdersController < ApplicationController
    before_action :set_shop
    before_action :set_table, only:[:show,:create,:destroy, :new]
    
    def new
        order = @booking.orders.new
        @product_list = @shop.products
    end

    def show
        
        booking = @table.bookings.last
        @orders = booking.orders

        @subtotal = 0
        if @orders then
            @orders.each do |order|
                @subtotal += order.price * order.quantity
            end
        end
        respond_to do |format|
            format.js
        end
    end
    def create
        
        product_data = @shop.products.find(params[:product_data])

        # if @booking.orders.find_by(:product =>product_data.name) then
        #     order = @booking.orders.find_by(:product =>product_data.name)
        #     order.quantity += 1
        # else
        new_product = {product:product_data.name,quantity:1,price:product_data.price,status:'Pendiente'}
        order = @booking.orders.new(new_product)
        # end

        if order.save then
            redirect_back(fallback_location: root_path , notice: "#{product_data.name.capitalize()} fue agregado satisfactoriamente a la mesa #{@table.name} ")
        else
            render :new, status: :unprocessable_entity, alert:"No se pudo agregar el producto, intente más tarde."
        end
        
      
    end

    def destroy
       
        booking = @table.bookings.find(params[:booking_id])
        order = booking.orders.find(params[:order_id])
        order.destroy


      redirect_back( fallback_location:root_path, notice: "El producto fué borrado satisfactoriamente.")

    end
    private
    def set_shop
        @shop = Shop.find_by_nick(params[:shop_nick])
    end
    def set_table
        @place = @shop.places.find(params[:place_id])
        @table = @place.tables.find(params[:table_id])
        @booking = @table.bookings.last
    end
end
