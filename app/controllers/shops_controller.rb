class ShopsController < ApplicationController
before_action :set_shop, only: [:show, :destroy, :edit, :admin]

  def index
    @shops = Shop.all  
  end

  def show

  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end
  
  def admin
    @orders = Order.where(shop_id: Shop.find_by_nick(params[:shop_nick]).id)
    
  end
  private

  def set_shop
    @shop = Shop.find_by_nick(params[:shop_nick])
  end
end
