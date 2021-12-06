class CategoriesController < ApplicationController
  before_action :set_shop
  before_action :set_category, only:[:show,:edit,:update,:destroy]

  def index
    @categories = @shop.categories
  end

  def show

  end

  def new
    @category = @shop.categories.new
  end
  def edit

  end

  def create
    @category = @shop.categories.new(category_params)
    if @category.save
      redirect_back(fallback_location: root_path, notice: "La categoría se creó correctamente" )
    else
      render :new, status: :unprocessable_entity, alert:"No se pudo crear la categoría, intente más tarde."
    end
  end

  def update
  
    @category.update(category_params)
    if @category.save
      redirect_back(fallback_location: root_path, notice: "La categoría se actualizó correctamente" )
    else
      render :new, status: :unprocessable_entity, alert:"No se pudo modificar la categoría, intente más tarde."
    end
  
  end

  def destroy
    @category.destroy

    redirect_back(fallback_location: root_path, notice: "La categoría fué borrada satisfactoriamente.")
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_shop
    @shop = Shop.find_by_nick(params[:shop_nick])
  end
  def set_category
    @category = @shop.categories.find(params[:category_id])
  end
end
