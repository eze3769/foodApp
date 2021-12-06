class ProductsController < ApplicationController
    before_action :set_shop
    before_action :set_product, only:[:edit,:update,:destroy]
    
    def show

    end
    def new
      @product = @shop.products.new
      @categories = @shop.categories
    end
    def create
      @product = @shop.products.new(product_params)

      if @product.save
        redirect_back(fallback_location: root_path, notice: "El producto fué agregado satisfactoriamente.")
      else
        render :new, status: :unprocessable_entity 
      end
    end

    def edit
      @categories = @shop.categories
    end

    def update
      @product.update(product_params)
      if @product.save
        redirect_back(fallback_location: root_path, notice: "El producto fue actualizado correctamente" )
      else
        render :new, status: :unprocessable_entity, alert:"No se pudo modificar el producto, intente más tarde."
      end
    end

    def destroy
      @product.destroy

      redirect_back(fallback_location: root_path, notice: "El producto fué borrado satisfactoriamente.")
    end

    def details_modal

        @product_data = @shop.products.find(params[:product_data])
        
        respond_to do |format|
          format.js
        end
      end
  
      private 

      def product_params
        params.require(:product).permit(:name,:price,:category,:description,:image)
      end
      def set_shop
        @shop = Shop.find_by_nick(params[:shop_nick])
      end
      def set_product
        @product = @shop.products.find(params[:product_id])
      end
end
