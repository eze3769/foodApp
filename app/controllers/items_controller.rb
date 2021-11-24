class ItemsController < ApplicationController
    def create
        @order = Order.find(params[:order_id])
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

end
