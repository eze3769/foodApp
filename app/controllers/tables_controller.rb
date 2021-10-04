class TablesController < ApplicationController
    before_action :set_place, only:[:new,:create,:batch_create,:destroy]

    def new
        @table = @place.tables.new
        range = {from:0,to:0}
    end
    def create
        @table = @place.tables.new(table_params)

        if @table.save
          redirect_to shops_tables_manager_path, notice: "La mesa fué agregado satisfactoriamente."
        else
          render :new, status: :unprocessable_entity 
        end
    end
    def batch_create
        @table = @place.tables
        to= params[:table][:to]
        from = params[:table][:from]

        table_list = []
        existing_tables = []
        for i in (from.. to) do
            if !@table.find_by_name(i) then
                @table.create(name: i)
                puts i
                table_list.push(i)
            else
                existing_tables.push(i)
            end
        end
        table_names = ""
        tables_exists = ""
        table_list.each do |el|
            table_names += "#{el} "
        end
        existing_tables.each do |el|
            tables_exists += "#{el} "
        end
        tables_msg = "#{table_list != [] ? 'Se agregaron las mesas '+table_names+' satisfactoriamente.' : 'No se agregaron mesas'}"
        error_msg = "Las mesas "+tables_exists +" ya existen."
        message = tables_msg + " #{if existing_tables != [] then error_msg end}"

        redirect_to shops_tables_manager_path, notice: message
          
    end
    def edit

    end
    def destroy

    end

    private

    def set_shop 
        @shop = Shop.find_by_nick(params[:shop_nick])
    end
    def set_place
        set_shop
        @place = @shop.places.find(params[:place_id])
    end
    def table_params
        params.require(:table).permit(:name,:to,:from)
    end
end
