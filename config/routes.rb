Rails.application.routes.draw do
  root 'shops#index'

  scope 'shops' do
    
    
  end

  get '/:shop_nick', to:'shops#show', as:'shop_show'

  scope '/:shop_nick' do
    get '/admin', to:'shops#admin', as:'shop_admin'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
