class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
   
    def configure_permitted_parameters
        attributes = [:name,:nick,:category,:email,:address,:country,:state,:city,:background,:password]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end
    def after_sign_in_path_for(resource)
        stored_location_for(resource) || shop_show_path(:shop_nick => current_shop.nick)
      end
      
    def after_sign_out_path_for(resource_or_scope)
        root_path
    end
end
