class EmployeersController < ApplicationController
    before_action :set_shop
    before_action :set_employeer, only:[:edit,:update]
 
    def new
        @employeer = @shop.employeers.new
    end
    def create
        @employeer = @shop.employeers.new(employeer_params)

        if @employeer.save
          redirect_back(fallback_location: root_path, notice: "El empleado fué agregado satisfactoriamente.")
        else
          render :new, status: :unprocessable_entity, alert: "No se puedo agregar el usuario"
        end
    end
    def edit
  
    end
    def update
        @employeer.update(employeer_params)
        if @employeer.save
          redirect_back(fallback_location: root_path, notice: "El personal fue actualizado correctamente" )
        else
          render :new, status: :unprocessable_entity, alert:"No se pudo modificar el personal, intente más tarde."
        end
      end
    
    private
    def set_shop
        @shop = Shop.find(params[:shop_id])
    end
    def set_employeer
        @employeer = @shop.employeers.find(params[:employeer_id])
    end
    def employeer_params
        params.require(:employeer).permit(:name, :lastName, :identification, :phone, :shift)
      end
end
