class OrdersController < ApplicationController
    before_action :set_shop
    before_action :set_table, only:[:show,:create,:destroy, :new]
    
    def new
        last = @booking.orders.last.items
        if last == [] then 
            last.destroy
        end
        @order = @booking.orders.find(params[:order_id])
        @categories = @shop.categories

        if params[:search] == nil then
            @product_list = @shop.products
        else
            @product_list = @shop.products.where("name like ?","%#{params[:search]}%")
        end
    end


    def create
        @order = @booking.orders.new

        if @order.save then
            redirect_to orders_new_path(:order_id => @order.id)
        else
            redirect_to bookings_show_path, alert:"No se pudo crear la orden."
        end


    end

    def destroy
       
        booking = @table.bookings.find(params[:booking_id])
        order = booking.orders.find(params[:order_id])
        order.destroy


      redirect_to tables_show_path(:table_id => @table.id), notice: "La orden ##{order.id} fué borrado satisfactoriamente."

    end
    def update
        
        @order = Order.find(params[:order_id])
        status = @order.status
        
        if(status =="pendiente") then
            new_status = "en preparación"
            @order.takenByKitchen = DateTime.now
        elsif (status == "en preparación" )then
            new_status = "listo para entrega"
            @order.readyToServe = DateTime.now
            ActionCable.server.broadcast(
                "orders_channel",
                {status: "ok"}
              )
        elsif (status == "listo para entrega") then
            new_status = "entregado"
            timeToServe = DateTime.now
        end
        
        if @order.update(status:new_status) then
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path, alert:"no se pudo actualizar el pedido")
        end
    end

    def broadcast
        order = Order.find(params[:order_id])
        order.update(status: 'pendiente')
        
        ActionCable.server.broadcast(
            "orders_channel",
            {order: order,
                items: order.items}
          )
        redirect_to tables_show_path, message:"Pedido enviado para su preparación."
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
