Rails.application.routes.draw do
  
  devise_for :shops, except: %w[shops#new shops#create]
  root 'shops#index'

  scope 'shops' do
    get 'new', to:'shops#new',as:'shop_new'
    post '/',to:'shops#create',as:'shop_create'   
  end

  get '/:shop_nick', to:'shops#show', as:'shop_show'
  get '/:shop_nick/edit', to:'shops#edit', as:'shop_edit'
  patch '/:shop_nick', to:'shops#update', as:'shop_update'

  scope '/:shop_nick' do
    scope '/admin' do
      get '/', to:'shops#admin', as:'shop_admin'
      get '/configuration',to:'shops#configuration',as:'shops_configuration'
      get '/manager', to:'shops#manager', as:'shops_manager'
      scope 'bookings' do
        get '/', to: 'bookings#index',as:'bookings_index'
        get '/:booking_id', to:'bookings#show', as:'bookings_show'

      end
      

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
              get 'edit',to:'tables#edit',as:'tables_edit'
              delete '/',to:'tables#destroy',as:'tables_destroy'

              scope '/bookings' do
                post '/', to:'bookings#create',as:'bookings_create'
                post 'booking#close', to:'bookings#close',as:'bookings_close'

                scope ':booking_id' do
                  
                  patch '/', to:'bookings#update', as:'bookings_update'
                  get '/edit',to:'bookings#edit',as:'bookings_edit'

                  scope '/orders' do
                    get 'new(:search)', to: 'orders#new',as:'orders_new'
                    post '/',to:'orders#create',as:'orders_create'

                  scope 'items' do
                    post '/', to:'items#create', as:'items_create'
                    delete '/:item_id', to:'items#destroy',as:'items_destroy'
                  end
                  
                    scope '/:order_id' do
                      get '/', to:'orders#show', as:'orders_show'
                      delete '/',to:'orders#destroy',as:'orders_destroy'
                      post '/confirm',to:'orders#broadcast',as:'orders_broadcast'
                     
                    end
                  end
                end
              end
            end
            
          end

        end
        
      end
      scope 'employeers' do  
        get 'new', to:'employeers#new',as:'employeers_new'
        post '/', to:'employeers#create',as:'employeers_create'    

        scope ':employeer_id' do
          get '/',to:'employeers#show',as:'employeers_show'
          delete '/', to:'employeers#destroy', as:'employeers_destroy'
          patch '/',to:'employeers#update',as:'employeers_update'
          get '/edit',to:'employeers#edit',as:'employeers_edit'
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

      scope 'categories' do
        get '/', to:'categories#index', as:'categories_index'
        get 'new',to:'categories#new', as:'categories_new'
        post '/', to:'categories#create', as:'categories_create'
        
        scope '/:category_id' do
          get 'edit',to:'categories#edit', as:'categories_edit'
          patch '/', to:'categories#update', as: 'categories_update'
          delete '/', to:'categories#destroy', as: 'categories_destroy'
        end
      end

      get 'kitchen',to:"shops#kitchen",as:"shops_kitchen"
      patch '/kitchen/:order_id/stepUp', to:'orders#update', as:'orders_update'
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
