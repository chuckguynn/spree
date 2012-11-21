Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :users do
      member do
        put :generate_api_key
        put :clear_api_key
      end
    end
  end

  namespace :api do
    scope :module => :v1 do
      resources :products do
        resources :variants
        resources :product_properties
      end

      resources :images
      resources :variants, :only => [:index] do
      end

      resources :orders do
        resources :return_authorizations
        member do
          put :address
          put :delivery
          put :cancel
          put :empty
        end

        resources :line_items
        resources :payments do
          member do
            put :authorize
            put :purchase
            put :void
            put :credit
          end
        end

        resources :shipments do
          member do
            put :ready
            put :ship
          end
        end
      end

      resources :zones
      resources :countries, :only => [:index, :show]
      resources :addresses, :only => [:show, :update]
      resources :taxonomies do
        member do
          get :jstree
        end

        resources :taxons do
          member do
            get :jstree
          end
        end
      end

      resources :taxons, :only => [:index]
    end
  end
end
