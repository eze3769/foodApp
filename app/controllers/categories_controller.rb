class CategoriesController < ApplicationController
  def index
    @categories = @shop.categories
  end

  def show
    @category = @shop.categories.find(params[:category_id])
  end

  def edit
  end

  def create
  end

  def update
  end

  def delete
  end

  private

  def set_shop
    @shop = Shop.find_by_nick(params[:shop_nick])
  end
end
