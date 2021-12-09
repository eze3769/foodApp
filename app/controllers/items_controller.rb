class ItemsController < ApplicationController
    before_action :set_table 

    def create
        @order = @booking.orders.find(params[:order_id])
        selected = Product.find(params[:product_id])
        quantity = params[:quantity].to_i

        @item = @order.items.find_by_product_id(selected.id)
        if (@item) then
            @item.quantity += quantity
        else
            @item = @order.items.new
            @item.update({product_id: selected.id,
            quantity: quantity,
            observations: "sin observaciones"}
        )
        end
        
        if @item.save 
            redirect_back(fallback_location:root_path )
        else
            redirect_to orders_new_path(:order_id => @order) ,status: :unprocessable_entity, alert:"No se pudo agregar el producto, intente de nuevo."
        end
    end
    def destroy
        order = @booking.orders.find(params[:order_id])
        item = order.items.find(params[:item_id])
        item.destroy


      redirect_back(fallback_location:root_path, notice: "El producto #{item.product.name} fué borrado satisfactoriamente.")

    end
    private

    def set_table
        @shop = Shop.find_by_nick(params[:shop_nick])
        @place = @shop.places.find(params[:place_id])
        @table = @place.tables.find(params[:table_id])
        @booking = @table.bookings.last
    end

end
