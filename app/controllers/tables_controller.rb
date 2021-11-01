class TablesController < ApplicationController
    before_action :set_place, only:[:new,:show, :create,:batch_create,:destroy]

    def new
        @tables = @place.tables.sort{|a,b| a.name <=> b.name }
        @table = @place.tables.new
    end
    def show
        @place = @shop.places.find(params[:place_id])
        @table = @place.tables.find(params[:table_id])
        @booking = @table.bookings.last
        if @booking  
          @orders = @booking.orders 
        end
        @state = true
        if @booking == nil then
            @state = false
        elsif @booking.status == "closed" then
            @state = false
        end
        @subtotal = 0
        if @orders then
          @orders.each do |order|
              @subtotal += order.price * order.quantity
            end
        end
    end
    def create
        @tables = @place.tables
        @table = @place.tables.new(table_params)
        if !@tables.find_by(:name =>@table.name) then
            if @table.save
                redirect_to tables_new_path, notice: "La mesa #{@table.name} fué creada correctamente."
              else
                render :new, status: :unprocessable_entity 
              end
        else
            redirect_to tables_new_path, alert: "La mesa #{@table.name} ya existe."
        end
        
    end
    def batch_create
        @table = @place.tables
        to= params[:table][:to]
        from = params[:table][:from]

        table_list = []
        existing_tables = []
        for i in (from.. to) do
            if !@table.find_by(:name =>i) then
                @table.create!(name: i)
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

        redirect_to shops_tables_manager_path(:place_id =>@place.id), notice: message
          
    end
    def edit

    end
    def destroy
        @table = @place.tables.find(params[:table_id])
        @table.destroy
        redirect_to tables_new_path, notice: "La mesa fué borrada satisfactoriamente."
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
