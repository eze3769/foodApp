Rails.application.routes.draw do
  root 'shops#index'

  scope 'shops' do
    
    
  end

  get '/:shop_nick', to:'shops#show', as:'shop_show'

  scope '/:shop_nick' do
    scope '/admin' do
      get '/', to:'shops#admin', as:'shop_admin'
      scope '/orders' do
        get '/', to:'orders#index', as:'orders_index'
        get '/show#order', to:'orders#show', as:'orders_show'
       scope '/:place_id'do
        scope '/:table_id'do
          post 'booking', to:'bookings#create',as:'bookings_create'
      end
      end
      end
      get 'products',to:'products#show',as:'products_show'
      get 'products#modal/:product_data',to:'products#product_modal',as:'product_modal'
      get 'productslist#modal/',to:'products#products_list_modal',as:'products_list_modal'
      scope 'places' do
        get '/:place_id',to:'places#show',as:'place_show'
      # get '/#select:place_id',to:'orders_set_place'
    end
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
