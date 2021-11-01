Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'categories/edit'
  get 'categories/create'
  get 'categories/update'
  get 'categories/delete'
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
      get '/manager', to:'shops#manager', as:'shops_manager'
      get '/bookings', to: 'bookings#index',as:'bookings_index'

      scope 'places' do
        get '/new', to:'places#new',as:'places_new'
        
        post '/', to:'places#create',as:'places_create'
        delete '/:place_id', to:'places#destroy', as:'places_destroy'
        
        scope '/:place_id' do
          get '/',to:'places#show',as:'place_show'
          get '/edit',to:'places#edit',as:'places_edit'
          patch '/',to:'places#update',as:'places_update'

          scope 'tables' do
            get 'new', to:'tables#new',as:'tables_new'
            post '/batch',to:'tables#batch_create', as:'tables_batch_create'
            post '/',to:'tables#create',as:'tables_create'
            
            
            scope '/:table_id' do
              get '/',to:'tables#show',as:'tables_show'
              delete '/',to:'tables#destroy',as:'tables_destroy'

              scope '/bookings' do
                post '/', to:'bookings#create',as:'bookings_create'
                post 'booking#close', to:'bookings#close',as:'bookings_close'
                scope ':booking_id' do
                  patch '/', to:'bookings#update', as:'bookings_update'
                  get '/edit',to:'bookings#edit',as:'bookings_edit'

                  scope '/orders' do
                    get 'new', to: 'orders#new',as:'orders_new'
                    post '/',to:'orders#create',as:'orders_create'
                    get '/show#order', to:'orders#show', as:'orders_show'
                    delete '/:order_id',to:'orders#destroy',as:'orders_destroy'
                  end
                end
              end
            end
            
          end

        end
        
      end
      scope 'products' do  
        get 'new', to:'products#new',as:'products_new'
        post '/', to:'products#create',as:'products_create'
        get '/modal/:product_data',to:'products#details_modal',as:'product_modal'
        

        scope ':product_id' do
          get '/',to:'products#show',as:'products_show'
          delete '/', to:'products#destroy', as:'products_destroy'
          patch '/',to:'products#update',as:'products_update'
          get '/edit',to:'products#edit',as:'products_edit'
        end
      end
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
