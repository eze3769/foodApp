Rails.application.routes.draw do
  root 'shops#index'

  scope 'shops' do
    get 'new', to:'shops#new',as:'shop_new'
    post '/',to:'shops#create',as:'shop_create'
    
  end

  get '/:shop_nick', to:'shops#show', as:'shop_show'

  scope '/:shop_nick' do
    scope '/admin' do
      get '/', to:'shops#admin', as:'shop_admin'
      get '/configuration',to:'shops#configuration',as:'shops_configuration'

      scope 'places' do
        get '/new', to:'places#new',as:'places_new'
        post '/', to:'places#create',as:'places_create'
      end
      scope 'products' do
        get 'new', to:'products#new',as:'products_new'
        post '/', to:'products#create',as:'products_create'
        delete '/:product_id', to:'products#destroy', as:'products_destroy'
        get '/:product_id/edit',to:'products#edit',as:'products_edit'
        patch '/:product_id/',to:'products#update',as:'products_update'
      end
      scope '/orders' do
        get '/', to:'orders#index', as:'orders_index'
        post '/',to:'orders#create',as:'orders_create'
        get '/show#order', to:'orders#show', as:'orders_show'
       scope '/:place_id'do
        scope '/:table_id'do
          post 'booking', to:'bookings#create',as:'bookings_create'
          post 'booking#close', to:'bookings#close',as:'bookings_close'
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
