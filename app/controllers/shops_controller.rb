class ShopsController < ApplicationController
  before_action :set_correct_url, except: [:show, :index, :new]
  before_action :set_shop, only: [:show]
  before_action :set_current_shop, only: [:destroy,:update, :edit, :admin, :config, :manager, :kitchen]
  before_action :authenticate_shop!,except: [:index,:show,:new, :create]


  def index
    if current_shop then @shop = current_shop end
    if params[:search] == nil then
      @shops = Shop.all
    else
      @shops = Shop.where("name like ?","%#{params[:search]}%")
    end
  end

  def show
    @products = @shop.products.where(ecommerce: true)
    @categories = @shop.categories
    if params[:search] == nil then
      @product_list = @products
    else
      @product_list = @products.where("name like ?","%#{params[:search]}%")
    end
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
    @shop.update(shop_params)
      if @shop.save
        redirect_to shops_configuration_path, notice: "El comercio fue actualizado correctamente" 
      else
        render :edit, status: :unprocessable_entity, alert:"No se pudo modificar el comercio, intente más tarde."
      end
  end
  
  def admin
   
    
  end
  def kitchen
    pendents = @shop.orders.where(status: "pendiente").sort{|a,b| a.created_at <=> b.created_at }
    taken = @shop.orders.where(status: "en preparación").sort{|a,b| a.created_at <=> b.created_at }
    @orders = taken + pendents
  end
  def manager
    @orders_ready = []
    if params[:place_id]
        @place = @shop.places.find(params[:place_id])
    else
        @place = @shop.places.first
    end
    if @place then
      @tables = @place.tables
      if @tables then
        @tables = @place.tables.sort{|a,b| a.name <=> b.name }
        
        
        @tables.each do |table|
          table.bookings.where(status: "open").each do |bookings|
          @orders_ready += bookings.orders.where(:status => "listo para entrega")
          end
        end
      end
    end

    

  end
  def configuration
    @shop = Shop.find_by_nick(params[:shop_nick])
    @products = @shop.products
  end
  private

  def set_correct_url
    if (current_shop) then
      if (current_shop != Shop.find_by_nick(params[:shop_nick]))
        redirect_to shop_admin_path(current_shop.nick)
      end
    end
  end

  def set_current_shop
    @shop = current_shop
  end
  def set_shop
    @shop = Shop.find_by_nick(params[:shop_nick])
  end
  
  def shop_params
    params.require(:shop).permit(:name,:nick,:category,:email,:address,:country,:state,:city,:background,:password,:logo)
  end
end
