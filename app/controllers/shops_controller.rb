class ShopsController < ApplicationController
before_action :set_shop, only: [:show, :destroy, :edit, :admin, :config, :tables_manager]

  def index
    @shops = Shop.all  
  end

  def show

  end

  def new
    @shop = Shop.new
  end
  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      redirect_to shop_show_path(@shop.nick), notice: "El comercio fué creado satisfactoriamente."
    else
      render :new, status: :unprocessable_entity 
    end

  end

  def destroy
  end

  def edit
  end

  def update
  end
  
  def admin
   
    
  end

  def tables_manager
        
    if params[:place_id]
        @place = @shop.places.find(params[:place_id])
    else
        @place = @shop.places.first
    end
    @tables = @place.tables.sort{|a,b| a.name <=> b.name }
    
   
  end
  def configuration
    @shop = Shop.find_by_nick(params[:shop_nick])
    @products = @shop.products
  end
  private

  def set_shop
    @shop = Shop.find_by_nick(params[:shop_nick])
  end
  def shop_params
    params.require(:shop).permit(:name,:nick,:category,:email,:address,:country,:state,:city,:background)
  end
end
